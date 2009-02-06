use strict;
use warnings;
use Data::Dumper;
use LWP::UserAgent;
use JSON;

my $ua = LWP::UserAgent->new;
my $api_key = shift @ARGV;
if ( ! defined $api_key ) {
    print STDERR "No API key supplied\n";
    exit 0;
}
my $resp = $ua->get( 'http://beta-api.etsy.com/v1/?api_key=' . $api_key );
if ( ! $resp->is_success ) {
    print STDERR "Error getting method table: " . $resp->status_line . "\n";
    exit 0;
}

my $method_response = from_json $resp->content;

$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 0;
print qq(
package WebService::Etsy::Methods;
use strict;
use warnings;
use JSON;
use Carp;
use WebService::Etsy::Response;
use WebService::Etsy::Result;
);

my $method_template = join "", <DATA>;
my %typeMap = (
    int          => 'Int',
    listing      => 'Listing',
    string       => 'String',
    shop         => 'Shop',
    user         => 'User',
    tag          => 'Tag',
    method       => 'Method',
    'gift-guide' => 'GiftGuide',
);

for my $method ( @{ $method_response->{ results } } ) {
    my $code = $method_template;
    my $params = $method->{ params };
    $params = ( $params ) ? "%{ " . Dumper( $params ) . " }": "()";
    $code =~ s/\[% name %\]/$method->{ name }/g;
    $code =~ s/\[% uri %\]/$method->{ uri }/g;
    $code =~ s/\[% type %\]/$typeMap{ $method->{ type } }/g;
    $code =~ s/\[% params %\]/$params/g;
    print $code;
}
print "\n1;\n";

__DATA__
sub [% name %] {
    my $self = shift;
    my %args = @_;
    for ( qw( ua api_key base_uri ) ) {
        if ( ! exists $args{ $_ } ) {
            $args{ $_ } = $self->$_();
        }
    }
    if ( ! $args{ api_key } ) {
        croak "No API key specified";
    }
    my $uri = "[% uri %]";
    my @missing;
    my %params = [% params %];
    $params{ api_key } = "";
    while( $uri =~ /{(.+?)}/g ) {
        my $param = $1;
        if ( ! exists $args{ $param } ) {
            push @missing, $param;
        } else {
           $uri =~ s/{(.+?)}/$args{ $param }/;
           delete $params{ $param };
        }
    }
    for ( keys %params ) {
        if ( $args{ $_ } ) {
            $params{ $_ } = $args{ $_ };
        } else {
            delete $params{ $_ };
        }
    }
    if ( scalar @missing ) {
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to [% name %]: " . join ", ", @missing );
        return;
    }
    my $params = join "&", map{ "$_=$params{ $_ }" } keys %params;
    $uri = $args{ base_uri } . $uri . "?" . $params;
    my $resp = $args{ ua }->get( $uri );
    if ( ! $resp->is_success ) {
        $self->last_error( "Error getting resource $uri: " . $resp->status_line );
        return;
    }
    my $data = from_json( $resp->content );
    for ( 0 .. $#{ $data->{ results } } ) {
        if ( ref $data->{ results }->[ $_ ] ) {
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Result::[% type %]';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Result::[% type %]';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}


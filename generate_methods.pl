use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Data::Dumper;

$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 0;

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

print qq(
package WebService::Etsy::Methods;
use strict;
use warnings;
);

for my $method ( @{ $method_response->{ results } } ) {
    my $name = $method->{ name };
    my $uri  = $method->{ uri };
    my $type = $typeMap{ $method->{ type } };
    my $params = $method->{ params };
    $params = ( $params ) ? Dumper( $params ) : '{}';
    print qq(
sub $name {
    my \$self = shift;
    my \$info = {
        name => '$name',
        uri  => '$uri',
        type => '$type',
        params => $params,
    };
    return \$self->_call_method( \$info, \@_ );
}
);
}
print "\n1;\n";

package WebService::Etsy;

use strict;
use warnings;
use LWP::UserAgent;
use base qw( Class::Accessor WebService::Etsy::Methods );
__PACKAGE__->mk_accessors( qw( ua api_key base_uri last_error ) );

our $VERSION = '0.2';

=head1 NAME

WebService::Etsy - Access the Etsy REST API.

=cut

=head1 SYNOPSIS

    my $api = WebService::Etsy->new( api_key => 'key' );

    # Call API methods as object methods
    my $resp = $api->getUsersByName( search_name => 'test' );
    die $api->last_error if ( ! defined $resp );

    # Returns a Response object which has methods
    print "Found: " . $resp->count . " users\n";
    print "Have: " . scalar @{ $resp->results } . " results\n";

    # But also behaves like an arrayref of Result objects
    for ( @$resp ) {
        # Results are objects, like WebService::Etsy::User
        print $_->user_name, "\n";
    }

    $resp = $api->getUserDetails( user_id => 'testuser' );
    # As a convenience, you can call Result object methods
    # on the Response object, which will be called on the first
    # Result object so
    print $resp->user_name, "\n";
    # is the same as
    print $resp->[ 0 ]->user_name, "\n";

=head1 DESCRIPTION

Note: this module is alpha code - a fairly functional proof of concept. The API itself is in beta. Details are at L<http://www.etsy.com/storque/etsy-news/tech-updates-handmade-code-etsys-beta-api-3055/>.

This module accesses the Etsy API, as described at L<http://developer.etsy.com/>.

The API is RESTful, and returns JSON. This module abstracts this away to present a standard Perl object interface.

The API methods are generated from details returned by the C<getMethodsTable> API method. A pre-built package containing the methods is shipped with this distribution, but you can re-build it using the "generate_methods.pl" script that is distributed with this code:

   perl generate_methods.pl api_key > Methods.pm

C<Methods.pm> should then replace the existing C<WebService::Etsy::Methods> file in your Perl library.

Currently the data is provided just as it comes back from the Etsy API. Future development will include caching, automatic retrieval of larger data sets, cross-object references, etc.

Calls to the API methods of the C<WebService::Etsy> object will return a L<WebService::Etsy::Response> object. See that object's documentation on the methods available.

The Response object contains an arrayref of L<WebService::Etsy::Result> objects, which implement interfaces to match the documentation at L<http://developer.etsy.com/docs#resource_types>. See the L<WebService::Etsy::Result> page for documentation on specific methods.

=head1 METHODS

=over 4

=item C<new( %opts )>

Create a new API object. Takes a hash of options which can include C<ua>, C<api_key>, and C<base_uri>, which correspond to setting the values of the relevant methods (described below).

=item C<api_key( $key )>

Get/set the API key to use for API requests.

=item C<base_uri( $uri )>

Get/set the base URI for requests. Defaults to "http://beta-api.etsy.com/v1".

=item C<ua( $agent )>

Get/set the user agent object that will be used to access the API server. The agent should be an object that implements the same interface as L<LWP::UserAgent>.

By default, it's an LWP::UserAgent with the agent string "WebService::Etsy".

=item C<last_error>

Returns the message from the last error encountered.

=back

=head1 API METHODS

API methods take a hash of parameters. In the event of an error, they will return undef, and the error message can be retrieved using the C<last_error()> method.

    my $resp = $api->getUserDetails( user_id => 'testuser', detail_level => 'high' );

See L<http://developer.etsy.com/docs#commands> for more details on the methods and parameters.

Any API method will also accept C<ua>, C<base_uri>, or C<api_key> arguments which will override those configured in the API object.

=cut

sub new {
    my $proto = shift;
    my $class = ref ( $proto ) || $proto;
    my $self = bless {}, $class;
    my %args = @_;

    $self->ua( $args{ ua } || LWP::UserAgent->new( agent => 'WebService::Etsy' ) );
    $self->base_uri( $args{ base_uri } || 'http://beta-api.etsy.com/v1' );
    $self->api_key( $args{ api_key } );
    return $self;
}

=head1 SEE ALSO

L<http://www.etsy.com/storque/etsy-news/tech-updates-handmade-code-etsys-beta-api-3055/>, L<http://developer.etsy.com/>, L<WebService::Etsy::Response>, L<WebService::Etsy::Result>.

=head1 AUTHOR

Ian Malpass (ian-cpan@indecorous.com)


=head1 COPYRIGHT

Copyright 2003-2007, Ian Malpass

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;

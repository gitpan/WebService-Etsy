package WebService::Etsy::Response;

use strict;
use warnings;
use Carp;

use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( results params count type ) );
our( $AUTOLOAD );

=head1 NAME

WebService::Etsy::Response - Returned values from the Etsy API.

=head1 SYNOPSIS

    my $resp = $api->getFeaturedSellers( detail_level => 'medium' );
    # call methods on the object
    print $resp->count . " featured sellers\n";
    # use the object like an arrayref of results
    for my $shop ( @$resp ) {
        print $shop->shop_name, "\n";
    }

=head1 DESCRIPTION

This class encapsulates the response from the API, as described at L<http://developer.etsy.com/docs#api_response_structure>.

=head2 Arrayification

For convenience, the response object behaves like an arrayref of result objects when used as such.

=head2 Stringification

When used in a scalar context, the response object will return a comma-separated list of stringified result objects. This is noteworthy for the case of

    print $api->getServerEpoch() . "\n";

which will print the epoch directly, without having to do something like

    print $api->getServerEpoch()->results->[ 0 ]->value . "\n";

=head1 METHODS

=over 4

=item C<results>

An arrayref of result objects. Using the response object as an arrayref accesses this results arrayref.

=item C<params>

A hashref of the parameters supplied to the method call.

=item C<count>

The number of results found (not necessarily the number returned).

=item C<type>

The result objects' type.

=back

=head1 AUTOLOADED METHODS

As a convenience, the response object will accept method calls the belong to its result objects. The method calls will be executed on the first object in the results arrayref. This allows you to use the response object just like a result object, which is useful when a method call (e.g. C<getUserDetails>) is expected to return one and only one result.

Note that C<WebService::Etsy::Method> objects include methods that collide with C<WebService::Etsy::Response> object methods, in which case you'll need to use the longer form of C<$resp->[ 0 ]->method()> (although this shouldn't matter too much since there aren't currently any API methods that return only one method result).

=cut

use overload
    '""' => "stringify",
    '@{}' => "array",
    fallback => 1,
;    

sub stringify {
    return join ",", @{ $_[ 0 ]->results };
}

sub array {
    return $_[ 0 ]->results;
}

sub AUTOLOAD {
    my $self = shift;
    $AUTOLOAD =~ /::([^:]*?)$/;
    my $method = $1;
    if ( $self->results->[ 0 ]->can( $method ) ) {
        return $self->results->[ 0 ]->$method( @_ );
    } else {
        croak "No such method: $method";
    }
}

sub DESTROY {
}

#-------

=head1 RESULT OBJECTS

=head2 WebService::Etsy::String

The object behaves just like a string in scalar context. It does provide a C<value()> method if you need it.

=cut

package WebService::Etsy::String;

use overload '""' => "stringify", fallback => 1;

sub stringify {
    return ${ $_[ 0 ] };
}    

sub value {
    return $_[ 0 ]->stringify;
} 

#-------

=head2 WebService::Etsy::Int

The object behaves just like an integer in scalar context. It does provide a C<value()> method if you need it.

=cut

package WebService::Etsy::Int;
use base qw( WebService::Etsy::String );

#-------

=head2 WebService::Etsy::Tag

The object behaves just like an string in scalar context. It does provide a C<value()> method if you need it.

=cut

package WebService::Etsy::Tag;
use base qw( WebService::Etsy::String );

#-------

=head2 WebService::Etsy::User

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#users>.

Some of the methods may return undef if the relevant detail level was not requested.

=cut

package WebService::Etsy::User;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( user_name user_id url image_url_25x25 image_url_30x30 image_url_50x50 image_url_75x75 join_epoch city gender lat lon transaction_buy_count transaction_sold_count is_seller was_featured_seller materials last_login_epoch referred_user_count birth_day birth_month bio ) );

#-------

=head2 WebService::Etsy::Shop

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#shops>.

Some of the methods may return undef if the relevant detail level was not requested.

=cut

package WebService::Etsy::Shop;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( banner_image_url last_updated_epoch creation_epoch listing_count shop_name title sale_message announcement is_vacation vacation_message currency_code ) );

#-------

=head2 WebService::Etsy::Listing

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#listings>.

Some of the methods may return undef if the relevant detail level was not requested.

=cut

package WebService::Etsy::Listing;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( listing_id state title url image_url_25x25 image_url_50x50 image_url_75x75 image_url_155x125 image_url_200x200 image_url_430xN creation_epoch views tags materials price currency_code ending_epoch user_id user_name quantity description lat lon city ) );

#-------

=head2 WebService::Etsy::GiftGuide

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#gift_guides>.

=cut

package WebService::Etsy::GiftGuide;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( guide_id creation_tsz_epoch description title display_order guide_section_id guide_section_title ) );

#-------

=head2 WebService::Etsy::Method

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#methods>.

=cut

package WebService::Etsy::Method;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( name description uri params type http_method ) );

=head1 AUTHOR

Ian Malpass (ian-cpan@indecorous.com)


=head1 COPYRIGHT

Copyright 2003-2007, Ian Malpass

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;

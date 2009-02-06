package WebService::Etsy::Result;

use strict;
use warnings;

=head1 NAME

WebService::Etsy::Result - Returned results from the Etsy API.

=head1 SYNOPSIS

    my $resp = $api->getFeaturedSellers( detail_level => 'medium' );
    # call methods on the object
    print $resp->count . " featured sellers\n";
    # use the object like an arrayref of results
    for my $shop ( @$resp ) {
        # $shop is a WebService::Etsy::Result::Shop object
        print $shop->shop_name, "\n";
    }

=head1 DESCRIPTION

The API returns different result types - shops, users, listings, methods, tags, ints, and strings.

Each return type has its own corresponding Perl class, with methods appropriate to its contents.

=head1 RESULT OBJECTS

=head2 WebService::Etsy::Result::String

The object behaves just like a string in scalar context. It does provide a C<value()> method if you need it.

=cut

package WebService::Etsy::Result::String;

use overload '""' => "stringify", fallback => 1;

sub stringify {
    return ${ $_[ 0 ] };
}    

sub value {
    return $_[ 0 ]->stringify;
} 

#-------

=head2 WebService::Etsy::Result::Int

The object behaves just like an integer in scalar context. It does provide a C<value()> method if you need it.

=cut

package WebService::Etsy::Result::Int;
use base qw( WebService::Etsy::Result::String );

#-------

=head2 WebService::Etsy::Result::Tag

The object behaves just like an string in scalar context. It does provide a C<value()> method if you need it.

=cut

package WebService::Etsy::Result::Tag;
use base qw( WebService::Etsy::Result::String );

#-------

=head2 WebService::Etsy::Result::User

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#users>.

Some of the methods may return undef if the relevant detail level was not requested.

=cut

package WebService::Etsy::Result::User;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( user_name user_id url image_url_25x25 image_url_30x30 image_url_50x50 image_url_75x75 join_epoch city gender lat lon transaction_buy_count transaction_sold_count is_seller was_featured_seller materials last_login_epoch referred_user_count birth_day birth_month bio ) );

#-------

=head2 WebService::Etsy::Result::Shop

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#shops>.

Some of the methods may return undef if the relevant detail level was not requested.

=cut

package WebService::Etsy::Result::Shop;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( banner_image_url last_updated_epoch creation_epoch listing_count shop_name title sale_message announcement is_vacation vacation_message currency_code ) );

#-------

=head2 WebService::Etsy::Result::Listing

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#listings>.

Some of the methods may return undef if the relevant detail level was not requested.

=cut

package WebService::Etsy::Result::Listing;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( listing_id state title url image_url_25x25 image_url_50x50 image_url_75x75 image_url_155x125 image_url_200x200 image_url_430xN creation_epoch views tags materials price currency_code ending_epoch user_id user_name quantity description lat lon city ) );

#-------

=head2 WebService::Etsy::Result::GiftGuide

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#gift_guides>.

=cut

package WebService::Etsy::Result::GiftGuide;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( guide_id creation_tsz_epoch description title display_order guide_section_id guide_section_title ) );

#-------

=head2 WebService::Etsy::Result::Method

The object includes methods corresponding to the field values described at L<http://developer.etsy.com/docs#methods>.

=cut

package WebService::Etsy::Result::Method;
use base qw( Class::Accessor );
__PACKAGE__->mk_accessors( qw( name description uri params type http_method ) );

package WebService::Etsy::Result;

=head1 SEE ALSO

L<http://developer.etsy.com/docs#resource_types>, L<WebService::Etsy::Response>.

=head1 AUTHOR

Ian Malpass (ian-cpan@indecorous.com)


=head1 COPYRIGHT

Copyright 2003-2007, Ian Malpass

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;


package WebService::Etsy::Methods;
use strict;
use warnings;

sub getUserDetails {
    my $self = shift;
    my $info = {
        name => 'getUserDetails',
        uri  => '/users/{user_id}',
        type => 'User',
        params => {'user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFavorersOfUser {
    my $self = shift;
    my $info = {
        name => 'getFavorersOfUser',
        uri  => '/users/{user_id}/favorers',
        type => 'User',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFavorersOfListing {
    my $self = shift;
    my $info = {
        name => 'getFavorersOfListing',
        uri  => '/listings/{listing_id}/favorers',
        type => 'User',
        params => {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int','listing_id' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getUsersByName {
    my $self = shift;
    my $info = {
        name => 'getUsersByName',
        uri  => '/users/keywords/{search_name}',
        type => 'User',
        params => {'search_name' => 'string','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getShopDetails {
    my $self = shift;
    my $info = {
        name => 'getShopDetails',
        uri  => '/shops/{user_id}',
        type => 'Shop',
        params => {'user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFeaturedSellers {
    my $self = shift;
    my $info = {
        name => 'getFeaturedSellers',
        uri  => '/shops/featured',
        type => 'Shop',
        params => {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getShopsByName {
    my $self = shift;
    my $info = {
        name => 'getShopsByName',
        uri  => '/shops/keywords/{search_name}',
        type => 'Shop',
        params => {'sort_order' => 'enum(up, down)','search_name' => 'string','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFavoriteShopsOfUser {
    my $self = shift;
    my $info = {
        name => 'getFavoriteShopsOfUser',
        uri  => '/users/{user_id}/favorites/shops',
        type => 'Shop',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingDetails {
    my $self = shift;
    my $info = {
        name => 'getListingDetails',
        uri  => '/listings/{listing_id}',
        type => 'Listing',
        params => {'detail_level' => 'enum(low, medium, high)','listing_id' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListings {
    my $self = shift;
    my $info = {
        name => 'getListings',
        uri  => '/shops/{user_id}/listings',
        type => 'Listing',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFeaturedDetails {
    my $self = shift;
    my $info = {
        name => 'getFeaturedDetails',
        uri  => '/shops/{user_id}/listings/featured',
        type => 'Listing',
        params => {'user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFrontFeaturedListings {
    my $self = shift;
    my $info = {
        name => 'getFrontFeaturedListings',
        uri  => '/listings/featured/front',
        type => 'Listing',
        params => {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFavoriteListingsOfUser {
    my $self = shift;
    my $info = {
        name => 'getFavoriteListingsOfUser',
        uri  => '/users/{user_id}/favorites/listings',
        type => 'Listing',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getGiftGuideListings {
    my $self = shift;
    my $info = {
        name => 'getGiftGuideListings',
        uri  => '/gift-guides/{guide_id}/listings',
        type => 'Listing',
        params => {'guide_id' => 'int','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingsByKeyword {
    my $self = shift;
    my $info = {
        name => 'getListingsByKeyword',
        uri  => '/listings/keywords/{search_terms}',
        type => 'Listing',
        params => {'sort_order' => 'enum(up, down)','search_terms' => 'string','min_price' => 'float','max_price' => 'float','sort_on' => 'enum(created, updated, title, price, id)','search_description' => 'enum(true, false)','limit' => 'int','offset' => 'int','detail_level' => 'enum(low, medium, high)'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingsByTags {
    my $self = shift;
    my $info = {
        name => 'getListingsByTags',
        uri  => '/listings/tags/{tags}',
        type => 'Listing',
        params => {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int','tags' => 'string'},
    };
    return $self->_call_method( $info, @_ );
}

sub getChildTags {
    my $self = shift;
    my $info = {
        name => 'getChildTags',
        uri  => '/tags/{tag}/children',
        type => 'Tag',
        params => {'tag' => 'string'},
    };
    return $self->_call_method( $info, @_ );
}

sub getTopTags {
    my $self = shift;
    my $info = {
        name => 'getTopTags',
        uri  => '/tags/top',
        type => 'Tag',
        params => {},
    };
    return $self->_call_method( $info, @_ );
}

sub getGiftGuides {
    my $self = shift;
    my $info = {
        name => 'getGiftGuides',
        uri  => '/gift-guides',
        type => 'GiftGuide',
        params => {},
    };
    return $self->_call_method( $info, @_ );
}

sub getMethodTable {
    my $self = shift;
    my $info = {
        name => 'getMethodTable',
        uri  => '/',
        type => 'Method',
        params => {},
    };
    return $self->_call_method( $info, @_ );
}

sub getServerEpoch {
    my $self = shift;
    my $info = {
        name => 'getServerEpoch',
        uri  => '/server/epoch',
        type => 'Int',
        params => {},
    };
    return $self->_call_method( $info, @_ );
}

sub ping {
    my $self = shift;
    my $info = {
        name => 'ping',
        uri  => '/server/ping',
        type => 'String',
        params => {},
    };
    return $self->_call_method( $info, @_ );
}

1;

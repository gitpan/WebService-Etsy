
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

sub getFavorersOfShop {
    my $self = shift;
    my $info = {
        name => 'getFavorersOfShop',
        uri  => '/shops/{user_id}/favorers',
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

sub getAllListings {
    my $self = shift;
    my $info = {
        name => 'getAllListings',
        uri  => '/listings/all',
        type => 'Listing',
        params => {'sort_order' => 'enum(up, down)','sort_on' => 'enum(created, ending)','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getShopListings {
    my $self = shift;
    my $info = {
        name => 'getShopListings',
        uri  => '/shops/{user_id}/listings',
        type => 'Listing',
        params => {'section_id' => 'int','sort_order' => 'enum(up, down)','sort_on' => 'enum(created, price)','limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
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
        params => {'sort_order' => 'enum(up, down)','search_terms' => 'array(string)','min_price' => 'float','max_price' => 'float','sort_on' => 'enum(created, price)','search_description' => 'enum(true, false)','limit' => 'int','offset' => 'int','detail_level' => 'enum(low, medium, high)'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingsByTags {
    my $self = shift;
    my $info = {
        name => 'getListingsByTags',
        uri  => '/listings/tags/{tags}',
        type => 'Listing',
        params => {'sort_order' => 'enum(up, down)','sort_on' => 'enum(created, price)','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int','tags' => 'array(string)'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingsByMaterials {
    my $self = shift;
    my $info = {
        name => 'getListingsByMaterials',
        uri  => '/listings/materials/{materials}',
        type => 'Listing',
        params => {'sort_order' => 'enum(up, down)','sort_on' => 'enum(created, price)','materials' => 'array(string)','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingsByCategory {
    my $self = shift;
    my $info = {
        name => 'getListingsByCategory',
        uri  => '/listings/category/{category}',
        type => 'Listing',
        params => {'sort_order' => 'enum(up, down)','sort_on' => 'enum(created, price)','limit' => 'int','category' => 'string','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingsByColor {
    my $self = shift;
    my $info = {
        name => 'getListingsByColor',
        uri  => '/listings/color/{color}',
        type => 'Listing',
        params => {'color' => 'color_triplet','wiggle' => 'int','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getListingsByColorAndKeywords {
    my $self = shift;
    my $info = {
        name => 'getListingsByColorAndKeywords',
        uri  => '/listings/color/{color}/keywords/{search_terms}',
        type => 'Listing',
        params => {'color' => 'color_triplet','wiggle' => 'int','search_terms' => 'array(string)','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getTopTags {
    my $self = shift;
    my $info = {
        name => 'getTopTags',
        uri  => '/tags',
        type => 'Tag',
        params => {},
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

sub getTopCategories {
    my $self = shift;
    my $info = {
        name => 'getTopCategories',
        uri  => '/categories',
        type => 'Category',
        params => {},
    };
    return $self->_call_method( $info, @_ );
}

sub getChildCategories {
    my $self = shift;
    my $info = {
        name => 'getChildCategories',
        uri  => '/categories/{category}/children',
        type => 'Category',
        params => {'category' => 'string'},
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

sub getFeedbackForUser {
    my $self = shift;
    my $info = {
        name => 'getFeedbackForUser',
        uri  => '/users/{user_id}/feedback',
        type => 'Feedback',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFeedbackAsBuyer {
    my $self = shift;
    my $info = {
        name => 'getFeedbackAsBuyer',
        uri  => '/users/{user_id}/feedback/buyer',
        type => 'Feedback',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFeedbackAsSeller {
    my $self = shift;
    my $info = {
        name => 'getFeedbackAsSeller',
        uri  => '/users/{user_id}/feedback/seller',
        type => 'Feedback',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','offset' => 'int'},
    };
    return $self->_call_method( $info, @_ );
}

sub getFeedbackForOthers {
    my $self = shift;
    my $info = {
        name => 'getFeedbackForOthers',
        uri  => '/users/{user_id}/feedback/others',
        type => 'Feedback',
        params => {'limit' => 'int','user_id' => 'user_id_or_name','offset' => 'int'},
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

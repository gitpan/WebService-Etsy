package WebService::Etsy::Methods;
use strict;
use warnings;
use JSON;
use Carp;
use WebService::Etsy::Response;

sub getUserDetails {
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
    my $uri = "/users/{user_id}";
    my @missing;
    my %params = %{ {'user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getUserDetails: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::User';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::User';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getFavorersOfUser {
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
    my $uri = "/users/{user_id}/favorers";
    my @missing;
    my %params = %{ {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getFavorersOfUser: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::User';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::User';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getFavorersOfListing {
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
    my $uri = "/listings/{listing_id}/favorers";
    my @missing;
    my %params = %{ {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int','listing_id' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getFavorersOfListing: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::User';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::User';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getUsersByName {
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
    my $uri = "/users/keywords/{search_name}";
    my @missing;
    my %params = %{ {'search_name' => 'string','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getUsersByName: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::User';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::User';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getShopDetails {
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
    my $uri = "/shops/{user_id}";
    my @missing;
    my %params = %{ {'user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getShopDetails: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Shop';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Shop';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getFeaturedSellers {
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
    my $uri = "/shops/featured";
    my @missing;
    my %params = %{ {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getFeaturedSellers: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Shop';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Shop';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getShopsByName {
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
    my $uri = "/shops/keywords/{search_name}";
    my @missing;
    my %params = %{ {'sort_order' => 'enum(up, down)','search_name' => 'string','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getShopsByName: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Shop';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Shop';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getFavoriteShopsOfUser {
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
    my $uri = "/users/{user_id}/favorites/shops";
    my @missing;
    my %params = %{ {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getFavoriteShopsOfUser: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Shop';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Shop';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getListingDetails {
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
    my $uri = "/listings/{listing_id}";
    my @missing;
    my %params = %{ {'detail_level' => 'enum(low, medium, high)','listing_id' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getListingDetails: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getListings {
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
    my $uri = "/shops/{user_id}/listings";
    my @missing;
    my %params = %{ {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getListings: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getFeaturedDetails {
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
    my $uri = "/shops/{user_id}/listings/featured";
    my @missing;
    my %params = %{ {'user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getFeaturedDetails: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getFrontFeaturedListings {
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
    my $uri = "/listings/featured/front";
    my @missing;
    my %params = %{ {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getFrontFeaturedListings: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getFavoriteListingsOfUser {
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
    my $uri = "/users/{user_id}/favorites/listings";
    my @missing;
    my %params = %{ {'limit' => 'int','user_id' => 'user_id_or_name','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getFavoriteListingsOfUser: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getGiftGuideListings {
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
    my $uri = "/gift-guides/{guide_id}/listings";
    my @missing;
    my %params = %{ {'guide_id' => 'int','limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getGiftGuideListings: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getListingsByKeyword {
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
    my $uri = "/listings/keywords/{search_terms}";
    my @missing;
    my %params = %{ {'sort_order' => 'enum(up, down)','search_terms' => 'string','min_price' => 'float','max_price' => 'float','sort_on' => 'enum(created, updated, title, price, id)','search_description' => 'enum(true, false)','limit' => 'int','offset' => 'int','detail_level' => 'enum(low, medium, high)'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getListingsByKeyword: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getListingsByTags {
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
    my $uri = "/listings/tags/{tags}";
    my @missing;
    my %params = %{ {'limit' => 'int','detail_level' => 'enum(low, medium, high)','offset' => 'int','tags' => 'string'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getListingsByTags: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Listing';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Listing';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getChildTags {
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
    my $uri = "/tags/{tag}/children";
    my @missing;
    my %params = %{ {'tag' => 'string'} };
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getChildTags: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Tag';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Tag';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getTopTags {
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
    my $uri = "/tags/top";
    my @missing;
    my %params = ();
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getTopTags: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Tag';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Tag';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getGiftGuides {
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
    my $uri = "/gift-guides";
    my @missing;
    my %params = ();
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getGiftGuides: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::GiftGuide';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::GiftGuide';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getMethodTable {
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
    my $uri = "/";
    my @missing;
    my %params = ();
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getMethodTable: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Method';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Method';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub getServerEpoch {
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
    my $uri = "/server/epoch";
    my @missing;
    my %params = ();
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to getServerEpoch: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::Int';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::Int';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}

sub ping {
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
    my $uri = "/server/ping";
    my @missing;
    my %params = ();
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
        $self->last_error( "Missing required argument" . ( ( scalar @missing > 1 ) ? "s" : "" ) . " in call to ping: " . join ", ", @missing );
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
            $data->{ results }->[ $_ ] = bless $data->{ results }->[ $_ ], 'WebService::Etsy::String';
        } else {
            my $value = $data->{ results }->[ $_ ];
            $data->{ results }->[ $_ ] = bless \$value, 'WebService::Etsy::String';
        }

    }
    return bless $data, "WebService::Etsy::Response";
}


1;

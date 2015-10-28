package WWW::SwaggerClient::Object::PhotoAlbumEntity;

require 5.6.0;
use strict;
use warnings;
use utf8;
use JSON qw(decode_json);
use Data::Dumper;
use Module::Runtime qw(use_module);
use Log::Any qw($log);
use Date::Parse;
use DateTime;

use base "WWW::SwaggerClient::Object::BaseObject";

#
#
#
#NOTE: This class is auto generated by the swagger code generator program. Do not edit the class manually.
#

my $swagger_types = {
    'photo_album_id' => 'int',
    'taken_on' => 'string',
    'photo_count' => 'int',
    'name' => 'string',
    'troop_photos' => 'ARRAY[TroopPhotoEntity]'
};

my $attribute_map = {
    'photo_album_id' => 'photo_album_id',
    'taken_on' => 'taken_on',
    'photo_count' => 'photo_count',
    'name' => 'name',
    'troop_photos' => 'troop_photos'
};

# new object
sub new { 
    my ($class, %args) = @_; 
    my $self = { 
        #ID of the photo album record
        'photo_album_id' => $args{'photo_album_id'}, 
        #Date the album was taken on as specified by the user
        'taken_on' => $args{'taken_on'}, 
        #Number of photos in this album
        'photo_count' => $args{'photo_count'}, 
        #Name used to identify the photo album
        'name' => $args{'name'}, 
        #An array of troop photos
        'troop_photos' => $args{'troop_photos'}
    }; 

    return bless $self, $class; 
}  

# get swagger type of the attribute
sub get_swagger_types {
    return $swagger_types;
}

# get attribute mappping
sub get_attribute_map {
    return $attribute_map;
}

1;

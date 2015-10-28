package WWW::SwaggerClient::Object::AwardTypeEntity;

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
    'active_achievements' => 'ARRAY[AchievementEntity]',
    'award_type_id' => 'int',
    'name' => 'string'
};

my $attribute_map = {
    'active_achievements' => 'active_achievements',
    'award_type_id' => 'award_type_id',
    'name' => 'name'
};

# new object
sub new { 
    my ($class, %args) = @_; 
    my $self = { 
        #Array of Achievements for this award type
        'active_achievements' => $args{'active_achievements'}, 
        #ID of the Award Type Record
        'award_type_id' => $args{'award_type_id'}, 
        #Name of the Award Type
        'name' => $args{'name'}
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

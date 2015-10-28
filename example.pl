use strict;
use warnings;
use lib qw( swagger-codegen/modules/lib );
use Data::Dumper;

# implicitly needs Log::Any
#                  URI::Query

use WWW::SwaggerClient::UsersApi;

my $users = WWW::SwaggerClient::UsersApi->new();

my $partner_token = "<your partner token>";
my $user_token = "<your user token>";

# 320853

my $ret = $users->g_et_version_users( 'x_partner_token' => $partner_token,
                                      'x_user_token'    => $user_token );

print Dumper( $ret );



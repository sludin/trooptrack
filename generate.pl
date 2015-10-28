use strict;
use warnings;
use JSON;
use LWP::UserAgent;
use IO::File;

use Data::Dumper;

my $config_file = "config.json";

# RL = Resource Listing
# AD = API Declaration


my $fh = IO::File->new( $config_file ) || die "Could not open $config_file";
my $json = do { local($/); <$fh> };
$fh->close;

my $config = decode_json( $json );

my $schema12_dir = $config->{'swagger12_dir'} || "swagger1.2";
my $schema2_dir  = $config->{'swagger2_dir'}  || "swagger2";
my $tt_rl_base   = $config->{'api_url'}       || "https://trooptrack.com:443/api/swagger_doc";
my $tt_rl_url    = $tt_rl_base . ".json";
my $tt_ad_dir    = $schema12_dir . "/swagger_doc";

my $ua = LWP::UserAgent->new();

# Fetch the Resource Listing file
my $rl = decode_json( fetch( $ua, $tt_rl_url ) );

my @ad;

# Fetch and convert the API Definition files
for my $api ( @{$rl->{apis}} )
{
  my $ad_filename = $api->{path};
  $ad_filename =~ s/\{format\}/json/;
  my $ad_url = $tt_rl_base . $ad_filename;

  my $ad = decode_json( fetch( $ua, $ad_url ) );

  # walk through they apis and operations makign the tweaks as necessary
  for my $api ( @{$ad->{apis}} )
  {
    for my $op ( @{$api->{operations}} )
    {
      # conversion tweak #1: convert all void return types to string
      $op->{type} = "string" if $op->{type} eq "void";

      for my $param ( @{$op->{parameters}} )
      {
        # conversion tweak #2: convert all 'String' aparameters to 'string'
        $param->{type} = "string" if $param->{type} eq "String";
      }
    }
  }

  push @ad, [ $ad_filename, $ad ];
}


# Write out the converted files

# Create the filename for storgin the Resource Listing filex
my ($rl_filename) = $tt_rl_url =~ m|/([^/]*)$|;
$rl_filename = $schema12_dir . "/" . $rl_filename;

# Create directories for storing the 1.2 schema files
mkdir $schema12_dir if ! -d $schema12_dir;
mkdir $tt_ad_dir    if ! -d $tt_ad_dir;

$fh = IO::File->new( $rl_filename, "w" ) || die "Could not open $rl_filename for write";
print $fh encode_json( $rl );
$fh->close();

for my $ad ( @ad )
{
  my $ad_filename = $tt_ad_dir . $ad->[0];
  my $fh = IO::File->new( $ad_filename, "w" ) || die "Could not open $ad_filename for write";
  print $fh encode_json( $ad->[1] );
  $fh->close();
}

mkdir $config->{swagger2_dir} if ! -d $config->{swagger2_dir};

my $convert_cmd = "$config->{'swagger-tools'} convert $rl_filename $tt_ad_dir/* --no-validation > $config->{swagger2_dir}/$config->{swagger2_schema}";
my $generate_cmd = "$config->{java} -jar $config->{'swagger-codegen'} generate -l perl -o ./ -i $config->{swagger2_dir}/$config->{swagger2_schema}";

system( $convert_cmd );
system( $generate_cmd );


sub fetch
{
  my $ua = shift;
  my $url = shift;

  my $resp = $ua->get( $url );

  if ( $resp->code() != 200 )
  {
    die "Received error when fetching file $url: " . $resp->code();
  }

  return $resp->content();
}

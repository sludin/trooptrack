use strict;
use warnings;
use JSON;
use IO::File;
use Data::Dumper;

my $fh = IO::File->new( "tt.json" ) || die $!;

my $json = "";

while( <$fh> ) { $json .= $_ }

$fh->close();

my $ref = decode_json( $json );



#print Dumper( $ref );


my $paths = $ref->{paths};

for my $path ( keys %$paths )
{
  for my $method ( keys %{$paths->{$path}} )
  {
    my $responses = $paths->{$path}->{$method}->{responses};

    my $ok = $responses->{200};

    if ( ! exists $ok->{schema} )
    {
      $ok->{schema}->{type} = 'string';
    }

  }
}

$json = encode_json( $ref );

print $json;

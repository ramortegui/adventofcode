
use Data::Dumper;
use Digest::MD5 qw(md5 md5_hex md5_base64);

my $password = 'bgvyzdsv';

my $i = 1;
while(true){
  my $encrpass = md5_hex($password.$i);
  #print "$encrpass\n";
  if ((substr $encrpass,0,6) eq "000000"){
      print $i;
      exit;
  }
  $i++;
}



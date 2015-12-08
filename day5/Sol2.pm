use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);
$nice = 0;
while (my $row = <$fh>) {
  chomp $row;
    if(repeatedLettersInBetween($row)){
      if(check_doubles($row)){
          $nice++;
        }
    }
    
}

print Dumper("Good $nice");

sub check_doubles($row){
#  print "Row 0 to ".(length($row)-1)."\n";
  foreach(0..(length($row)-2)){
      my $pair = substr($row,$_,2);
      foreach my $index (($_+2)..(length($row)-2)){
        my $temp_pair = substr($row,$index,2);
#        print " Checking $pair with $temp_pair index $index $_\n ";
        return 1 if $temp_pair eq $pair;
      }
      #     print "Loop $_\n";
  }
  return 0;
}


sub repeatedLettersInBetween{
  $row = shift;
  my $pas0 = "";
  my $pas1 = "";
  map {
    return 1 if $_ eq $pas0;
    $pas0 = $pas1;
    $pas1 = $_;
  } split("",$row);
  return 0;
}



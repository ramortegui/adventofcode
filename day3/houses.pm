use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);

my $total = 0;
my $arr = [];
my $x= 0,$y=0;
my $coordinates = ();
$coordinates->{$x."_".$y}=1;
while (my $row = <$fh>) {
  chomp $row; 
  map {
  if ($_ eq ">"){ $x++; print "right\n";}
  elsif ($_ eq "<"){ $x--;  print "left\n" }
  elsif ($_ eq "^"){ $y++; print "up\n";}
  else{ $y--; print "down\n" }

  $coordinates->{$x."_".$y}=1;
 } split("",$row);
}


print Dumper($coordinates);
print Dumper(scalar (keys %{$coordinates}));

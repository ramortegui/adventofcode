use Data::Dumper;
my $file = "fileRoboBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);

my $total = 0;
my $arr = [];
my $x= 0,$y=0, $xr = 0, $yr =0;
my $coordinates = ();
$coordinates->{$x."_".$y}=1;
my $i = 1;
while (my $row = <$fh>) {
  chomp $row; 
  map {
  if ($i%2==0){
    if ($_ eq ">"){ $x++; print "right\n";}
    elsif ($_ eq "<"){ $x--;  print "left\n" }
    elsif ($_ eq "^"){ $y++; print "up\n";}
    else{ $y--; print "down\n" }
    $coordinates->{$x."_".$y}=1;
  }
  else{
    if ($_ eq ">"){ $xr++; print "right\n";}
    elsif ($_ eq "<"){ $xr--;  print "left\n" }
    elsif ($_ eq "^"){ $yr++; print "up\n";}
    else{ $yr--; print "down\n" }
    $coordinates->{$xr."_".$yr}=1;
  }
  $i++;
 } split("",$row);
}

print Dumper($coordinates);
print Dumper(scalar (keys %{$coordinates}));

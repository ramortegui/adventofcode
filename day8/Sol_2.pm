use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);
my $total = 0;
while (my $row = <$fh>) {
  chomp $row;
  my $total_dec = 0;
  my $new_row = add_scapes($row)  ;
  print "$row - $new_row\n";
  $total += length($row);
  $new_total += length($new_row);
  
}

sub add_scapes{
  my $row = shift;
  my $new_row ="\"";
  map{
    if($_ eq "\""){
      $new_row .= '\"';
    }
    elsif($_ eq '\\'){
      $new_row .= '\\\\';
    }
    else{
      $new_row .= $_; 
    }
  }split("",$row);
  
  return $new_row.'"';
}

print "total is $total\n";
print "new_ total is $new_total\n";
print "Result ".($new_total - $total)."\n";

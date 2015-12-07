
my $file = "file.txt";
open(my $fh,'<:encoding(UTF-8)',$file);

my $total = 0;
while (my $row = <$fh>) {
  chomp $row;
  $total +=  get_quantity($row);
}

print "Total: ".$total;


sub get_quantity{
  my $case = shift;
  $small1 = 0;
  $small2 = 0;
  @side = split("x",$case);
  map{  
    if($small1 == 0){
      $small1 = $_;
    }
    else{
      if( $small1 >= $_ ){
        $small2 = $small1;
        $small1 = $_; 
      }
      elsif( $small2 == 0 || $small2 >= $_ ){
        $small2 = $_;
      }
    }
  } @side;
  

  return ($small1*$small2)+2*(@side[0]*$side[1])+2*(@side[1]*@side[2])+2*(@side[2]*@side[0]);
}

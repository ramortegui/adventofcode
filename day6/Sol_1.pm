use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);

my $arr = [];
foreach my $i (0..999){
  push @{$arr}, [];
  foreach my $j (0..999){
    $arr->[$i]->[$j] = 0;
  }
}




while (my $row = <$fh>) {
  chomp $row;
  follow_instructions($row);
}
count_ligths($arr);

sub follow_instructions{
  $row = shift;
  my @ins = split(" ",$row);
  my $i =0;
  my $command = @ins[$i];
  $i++;
  my $state = -1;
  if($command eq "turn"){
    $state = @ins[$i];
    $i++;
  }
  my $init_range = @ins[$i];
  $i++;
  $i++;
  my $end_range = @ins[$i];
  $i++;
  update_matrix($command, $state, $init_range, $end_range);

}

sub update_matrix{
  my ($command,$state,$init_range,$end_range)= @_;
  my ($x,$y) = split(",", $init_range);
  my ($xx,$yy) = split(",", $end_range);
  foreach my $i ($y..$yy){
    foreach my $j ($x..$xx){
      if($command eq "turn"){
        if($state eq "on"){
          $arr->[$i]->[$j] = 1 ;
        }
        else{
          $arr->[$i]->[$j] = 0 ;
        }
      }
      elsif($command eq "toggle"){
        $arr->[$i]->[$j] = $arr->[$i]->[$j] ? 0 : 1; 
      }
    }
  }
}

sub count_ligths{
  my $arr = shift;
  my $ligths = 0;
  for my $i (0..999){
    for my $j( 0..999){
      $ligths++ if $arr->[$i]->[$j];
    }
  }
  print "LIGTHS $ligths\n";
}




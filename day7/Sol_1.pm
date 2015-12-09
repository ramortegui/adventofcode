use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);
my $result =  {};
my $circuit = {};

while (my $row = <$fh>) {
  chomp $row;
  follow_instructions($row);
}



sub follow_instructions{
  $row = shift;
  my @ins = split(" ",$row);
  if( scalar @ins == 3  ){
    $result->{@ins[2]} = @ins[0];
  }
  elsif(scalar @ins == 4){
    if(@ins[0] eq 'NOT'){
      my $val = ""; 
      map { 
      if ($_ eq "0")
      { 
          $val.="1";
        }
        else 
        { 
            $val.="0";
          } 
        } split ("", unpack("B64", pack("n",int($ins[1]))));

      $result->{@ins[3]} = unpack( 'n', pack ('B64',$val));
      print "Setting  @ins[3] with: ".unpack( 'n', pack ('B64',$val))."\n";
    }
  }
  else{
      if(@ins[1] eq "LSHIFT"){
        $result->{@ins[4]} = int($result->{@ins[0]}) << int(@ins[2]);
      }
      elsif(@ins[1] eq "RSHIFT"){
       $result->{@ins[4]} = int($result->{@ins[0]}) >> int(@ins[2]);
      }
      else{
        if( @ins[1] eq "AND"){
          $result->{@ins[4]}  = int($result->{@ins[0]}) & int($result->{@ins[2]});
        }
        else{
          $result->{@ins[4]}  = int($result->{@ins[0]}) | int($result->{@ins[2]});
        }
     }
     print "Setting  @ins[4] with: ".$result->{@ins[4]}."\n";
  }
   

}

print Dumper($result);
print Dumper($result->{"a"});
print Dumper($result->{"lx"});

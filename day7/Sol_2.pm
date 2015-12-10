use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);
my $result =  {};
my $circuit = {};
my $link = {};

while (my $row = <$fh>) {
  chomp $row;
  my @first = split(" ",$row);
  $link->{ @first[(scalar @first)-1] } = $row;
}
  $link->{"b"} = "3176";
  print(find_circuit("a")."\n");

sub find_circuit{
  my $var = shift;
  my $instruction = $link->{$var};
  return follow_instructions($instruction);
}



sub follow_instructions{
  $row = shift;
#  print "Following $row\n";
  my @ins = split(" ",$row);
#  print (scalar @ins);
  if( scalar @ins == 1){
   return @ins[0];
  }
  elsif( $circuit->{@ins[(scalar @ins)-1]} ){
    return  $circuit->{@ins[(scalar @ins)-1]}; 
  }
  elsif( scalar @ins == 3  ){
    if (  $link->{@ins[0]} ){
      $circuit->{@ins[0]} = follow_instructions($link->{@ins[0]});
      return $circuit->{@ins[0]};
    }
    else{
      $circuit->{@ins[2]} = @ins[0];
      print "Assigned @ins[2] with value @ins[0]\n";
      return $circuit->{@ins[2]};
    }
  }
  elsif(scalar @ins == 4){
    if( $circuit->{$ins[1]} ){
      return $circuit->{$ins[1]};
    }
    else{
      
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
        } split ("", unpack("B64", pack("n",int(follow_instructions($link->{$ins[1]})))));

      $circuit->{@ins[3]} = unpack( 'n', pack ('B64',$val));
      return $circuit->{@ins[3]};
    }
  }
  else{
      if(@ins[1] eq "LSHIFT"){
        $circuit->{@ins[4]} = int(follow_instructions($link->{@ins[0]}||@ins[0])) << int(@ins[2]);
        return $circuit->{@ins[4]};
      }
      elsif(@ins[1] eq "RSHIFT"){
        $circuit->{@ins[4]} = int(follow_instructions($link->{@ins[0]}||@ins[0])) >> int($ins[2]);
        return $circuit->{@ins[4]};
      }
      else{
        if( @ins[1] eq "AND"){
          $circuit->{@ins[4]}  = int(follow_instructions($link->{@ins[0]}||@ins[0])) & int(follow_instructions($link->{@ins[2]||@ins[2]}));
          return $circuit->{@ins[4]};
        }
        else{
          $circuit->{@ins[4]}  = int(follow_instructions($link->{@ins[0]}||@ins[0])) | int(follow_instructions($link->{@ins[2]}||@ins[2]));
          return $circuit->{@ins[4]};
        }
     }
     print "Don't know what to do\n";
  }
   

}


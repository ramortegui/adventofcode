use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);
my $total = 0;
while (my $row = <$fh>) {
  chomp $row;
   $total += scalar split("",$row);
   $total -= length(eval $row);
}

print "total is $total\n";

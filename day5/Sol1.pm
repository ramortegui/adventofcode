use Data::Dumper;
my $file = "fileBig.txt";
open(my $fh,'<:encoding(UTF-8)',$file);
$nice = 0;
while (my $row = <$fh>) {
  chomp $row;
  if(checkThreeVowels($row)){
    if(repeatedLettersInRow($row)){
        $nice++ unless $row =~ /ab|cd|pq|xy/;
    }
  }
    
}

print Dumper("Good $nice");

sub repeatedLettersInRow{
  $row = shift;
  my $pas = "";
  map {
    return 1 if $pas eq $_;
    $pas = $_;
  } split("",$row);
  return 0;
}

sub checkThreeVowels{
  my ($row) = @_ ;
  my $vowels = 0;
  map{
    if( $_ =~ /a|e|i|o|u/ ){
        $vowels++;
        return 1 if $vowels >= 3;
    }
  } split("",$row);
  return 0;
}


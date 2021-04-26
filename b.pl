open (IN, $ARGV[0]);
while (<IN>) {
    $a{(split)[0]}++;

}
open (IN, $ARGV[1]);
while (<IN>) {
    $c = (split)[0];
    $a{$c} || print "$c\tXContigOther\n";
}

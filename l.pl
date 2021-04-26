use English;

$/ = ">";

while (<>) {
    chomp;
    ($n) = /(\S+)/;
    $l = length (join ("", $POSTMATCH =~ /\S+/g));
    print "$n\t$l\n";
}

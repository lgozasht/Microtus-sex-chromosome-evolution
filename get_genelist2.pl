open (IN, $ARGV[0]);
while (<IN>) {

    s/\*//g;
    $get{(split)[0]}++;
}


open (IN, $ARGV[1]);
$/ = ">";
while (<IN>) {
    chomp;
    /(\S+?):/;
    $get{$1} && print ">$_";

}



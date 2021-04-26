open (IN, $ARGV[0]);
while (<IN>) {
    s/\*//;
    $get{(split)[0]}++;
}


open (IN, $ARGV[1]);
while (<IN>) {
    ((split)[0]) =~ /(\S+?):/;

    $get{$1} && $get2{(split)[1]}++;
}


open (IN, $ARGV[2]);
$/ = ">";
while (<IN>) {
    /\S+/;
$get2{$&} && print;
}
	
    

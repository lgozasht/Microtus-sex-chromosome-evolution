open (IN, $ARGV[0]);
while (<IN>) {
    next unless />\s*(\S+)/;
    $g{$1} = "X...";
}

open (IN, $ARGV[1]);
while (<IN>) {
    s/(?<=>)(?=(\S+))/$g{$1}/;
    
    print;

}

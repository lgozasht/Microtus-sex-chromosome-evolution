open (IN, $ARGV[0]);
while (<IN>) {
    ($s) = /(\d+)/;
    ($e) = /(\d+)\s+$/;

    for $i ($s..$e) {
	$yes[$i]++;
    }
}

open (IN, $ARGV[1]);
$/ = ">";
while (<IN>) {
    chomp;
    /^.+NC_022026.1:(\d+)/ || next;
    if ($yes[$1/100000]) {
	print ">$_";
    }
}

    
	    
	
    
    

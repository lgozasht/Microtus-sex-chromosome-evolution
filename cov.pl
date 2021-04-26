#Early draft of coverage script.  Not used for final analyses, I don't think.
while (<>) {
    $t{(split)[4]}[(split)[5]/20000]++;
}
foreach $k (keys %t) {
    $k =~ /PGA_scaffold9/ || next;
    #print join ("\n", @{$t{$k}});

    @a = sort {$a<=>$b} @{$t{$k}};
    $m = $a[$#a/2];
    for $i (@{$t{$k}}) {
	printf "%.10f\n", $i/$m;
    }
    for $a (@a) {
	$t[$a]++;
    }
    #next;


    $s = 0;
    for $a (@a) {
	$s += $a;
    }
    $s /= ($#a+1);
    $m || next;
    print "$k\t", $a[$#a/2], "\t", $s/$m, "\n";
}
die;

for $i (0..100) {
    ($i % 2) && next;
    printf "%d ", $t[$i];
}

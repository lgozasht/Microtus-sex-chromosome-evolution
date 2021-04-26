$/ = ">";
while (<>) {
    s/(\S+).+//;
    $h = $1;
    s/\([a-z,]+\-\d{4}\)//g;
    
    %t = ();
    $t = 0;
    foreach $b (/(\d{4})\)/g) {
	($b =~ /^.?1/) && next;
	($b =~ /2.?$/) || next;
	($b eq "2222") && next;
	$t{$b}++;
	$t++;
    }
    if (scalar keys %t) { /\S+/; print "$h\t$t\t";}
    foreach $b (sort keys %t) {print "$b:$t{$b}\t"}
    (scalar keys %t) && print "\n";
}

$window = 250000;

open (IN, "Micoch.Loci");
while (<IN>) {
    $current_places = int ((split)[2]/$window);
    $current_places || next;
    $places += $current_places;
    $places{(split)[1]} = $current_places;
}


@files = @ARGV;
foreach $f (@files) {
    open (IN, $f);
    $reads = 0;
    while (<IN>) {
	@F = split;
	($root) = $F[0] =~ /(\S+)\.\d+/;
	$place = $F[1]/$window;

	($place >= $places{$root}) && next;
	$reads{$f}++;

	$t{$F[0]}{$f}[$F[1]/$window]++;
    }
}
print "### Files (read numbers): ";
for $f (@files) {
    print "$f ($reads{$f}) ";
}
print "\n";


foreach $chr (keys %t) {
    ($root) = $chr =~ /(\S+)\.\d+/;
    print "# $chr\n";
    for $i (0..$places{$root}-1) {
	printf "%d..%d\t", $i*$window,($i+1)*$window;
	for $f (@files) {
	    printf "%.4f\t", $t{$chr}{$f}[$i]/$reads{$f}*$places;
	}
	print "\n";
    }
    print "\n";
}

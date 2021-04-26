open (IN, $ARGV[0]);
$/ = ">";
while (<IN>) {
    ($name,$chr,$coords) = /(\S+)\s*[\+\-](\S+):([\d\.\,]+)\n/;
    @names[$ch++] = $name;
    while ($coords =~ /(\d+)\.\.(\d+)/g) {
	$l{$name} += $2-$1+1-50;
    }
    $chr{$name} = $chr;
}
print "# @ARGV\n";


$/ = "\n";
for $i (1..$#ARGV) {
    #($ch++ > 10000) && last;
    open (IN, $ARGV[$i]);
    while (<IN>) {
	$name = (split(/\t/,$_))[2];
	$t{$name}[$i-1]++;
	$r[$i-1]++;
    }
}
print "# @r\n";
print "# Name mappable-positions reads reads-per-million\n";
foreach $n (@names) {
    print "$n\t$chr{$n}\t$l{$n}";
    for $i (0..$#ARGV-1) {
	printf "\t$t{$n}[$i]\t%.3f", $t{$n}[$i]/(0.0001+$r[$i])*1000000;

    }
    print "\n";
	
}

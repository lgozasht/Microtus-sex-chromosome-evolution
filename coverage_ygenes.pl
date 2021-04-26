open (IN, "ReadsPerGeneExint");
$junk = <IN>;
$files = <IN>;
$files =~ s/\.exint.bwtout//g;
$reads = <IN>;
@files = $files =~ /\S+/g;
@reads = $reads =~ /\S+/g;
for $i (1..$#files) {
    $reads{$files[$i]} = $reads[$i];
}



open (IN, "YGenes.exons");
$/ = ">";
while (<IN>) {
    /\n([A-Z]+)\s*\n/;
    $l = length $1;
    ($n) = /(\S+)\./;
    $l{$n} += $l-49;
}

foreach $file (@ARGV) {
    ($root) = $file =~ /(\S+)\.yreads/;
    system "bowtie -3 100 YGenes $file > $file.yge";
    open (IN, "$file.yge");
    $/ = "\n";
    while (<IN>) {
	$g = (split(/\t/,$_))[2];

	$t{$root}{$g}++;
    }
}

foreach $g (sort keys %l) {
    next unless $g =~ /\S/;
    print "$g\tYchromosomal\t$l{$g}";
    foreach $file (@files[1..$#files]) {
	printf "\t%d\t%.3f", $t{$file}{$g}, $t{$file}{$g}/$reads{$file}*1000000;
    }
    print "\n";
}

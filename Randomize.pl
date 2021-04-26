$/ = undef;
$_ = <>;
@lines = /.+/g;
for $set (1..1000) {
    open (OUT, ">temp");
    for $i (0..$#lines) {
	print OUT $lines[(scalar @lines) * rand ()];
	print OUT "\n";
    }
    close OUT;
    system "perl TEdensity.pl";
}
	

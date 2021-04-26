$/ = ">";
open (IN, $ARGV[0]);
while (<IN>) {
    chomp;
    ($gene) = /(\S+):/;
    $l = tr/A-Z/A-Z/;
    if ($l > $longest{$gene}) {
	$longest{$gene} = $l;
	$seq{$gene}  = ">$_";
    }
}

print join ("", values %seq);


open (IN, $ARGV[0]);
while (<IN>) {
    ((split)[2] eq "CDS") || next;
    ($gene) = /GeneID:(\S+?),/;
    ($pro) = /protein_id=(\S+?)[,\s]/g;
    $gene{$pro} = $gene;

}
$/ = ">";
open (IN, $ARGV[1]);
while (<IN>) {
    ($pro) = /(\S+)/;
    if ((length $_) > length ($longest{$gene{$pro}})) {
	$longest{$gene{$pro}} = $_;
    }
}

print join ("", values %longest);

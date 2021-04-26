open (IN, $ARGV[0]);
while (<IN>) {
    ((split)[2] eq "CDS") || next;
    ($gene) = /GeneID:(\S+?),/;
    ($pro) = /protein_id=(\S+?)[,\s]/g;
    $gene{$pro} = $gene;

}

open (IN, $ARGV[1]);
$/ = ">";
while (<IN>) {
    s/(?=(\S+))/$gene{$1}:/;
    print;
}



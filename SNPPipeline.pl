foreach $f (@ARGV) {
    system "perl get_genelist2.pl $f Micoch.XLinkedGenes.Longest.MinusAmplifications.Final > $f.genes";
    system "perl CallSynonNonsynon.pl $f.genes > $f.genes.synnon";
    system "perl ProcessSynonNonsynon.pl $f.genes.synnon > $f.genes.synnon.processed &";
}

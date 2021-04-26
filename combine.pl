while (<>) {
    push (@{$data{(split)[0]}},(split)[1])
}
for $ss (keys %data) {
    print "$ss\t";
    print join (" ", @{$data{$ss}});
    print "\n";
}

open (IN, $ARGV[0]);

while (<IN>) {
    @F = split;
    ($F[2] eq "gene") || next;
    $g{$F[0]}++;
    ($g) = /gene=(\S+?);/;
    $n{$g} = "$g{$F[0]}:$F[0]";
}

open (IN, $ARGV[1]);
$/ = ">";
while (<IN>) {
    chomp;
    ($g) = /:(\S+?):/;
    print ">$n{$g} $_";
}
      


open (IN, "AllContigAssignments");
while (<IN>) {
    $assign{(split)[0]} = (split)[1];
}

open (IN, "AllLengths");
while (<IN>) {
    $length{$assign{(split)[0]}} += (split)[1];
}


#open (IN, "AllTransposases.Combined");
open (IN, "temp");
while (<IN>) {
    @F = split;
    $tes{$assign{$F[0]}} += $F[2]-$F[1]+1;
}

foreach $ss (keys %tes) {
    if ($ss =~ /\S/) {$sswrite = $ss}
    else {$sswrite = "Unassigned"}
    printf "$sswrite\t%.10f\n", $tes{$ss}/$length{$ss};
}


    

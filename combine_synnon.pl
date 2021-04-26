@sets =
    ("2222","2211","0011","2000:0200","0010:0001");
@names = ("Species_Difference","Xf","Xm","Female_singleton","Male_singleton","Ancestral_polymorphism","Other");
for $i (0..$#sets) {
    while ($sets[$i] =~ /\d+/g) {
	$set{$&} = $i;
    }
}



while (<>) {
    @F = /\S+/g;
    ($F[0] =~ /^.?1/) && next;
    @sites = /\/(\d+\S*)/g;

    if (exists $set{$F[0]}) {$set = $set{$F[0]};}
    elsif ($F[0] =~ /2.?$/) {$set = 5; print}
    else {$set = scalar $#names}
    @changes = /(\d+)\//g;
    for $i (0..2) {
	$tot_changes[$set][$i] += $changes[$i];
    }
}

for $i (0..$#tot_changes) {
    print "$names[$i]\t";
    for $j (0..2) {
	print "$tot_changes[$i][$j]/$sites[$j]\t";
    }
    print "\n";
}


			     
    

$/ = ">";
while (<>) {
    s/intron.+//g;
    $Mo = $_;
    $Mo =~ s/\([A-Z,]+\-\d+\)//g;
    s/[A-Z]\(([A-Z])[A-Z,]*\-2222\)/$1/g;
    $Xm = $_;
    $Xf = $_;
    $Xm =~ s/[A-Z]\(([A-Z])[A-Z,]*\-0011\)/$1/g;
    $Xf =~ s/[A-Z]\(([A-Z])[A-Z,]*\-2211\)/$1/g;
    $Xm =~ s/\([A-Z,]+\-\d+\)//g;
    $Xf =~ s/\([A-Z,]+\-\d+\)//g;
    print ">PV\n$Mo\n>Xf\n$Xf\n>Xm\n$Xm\n";
}

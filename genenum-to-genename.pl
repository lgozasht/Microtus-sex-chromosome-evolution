open (IN, $ARGV[0]);
while (<IN>) {
    ((split)[2] eq "gene") || next;
    ($id) = /GeneID:(\S+?),/;
    ($name) = /Name=(\S+?)[,\s;]/g;
    $name{$id} = $name;


}

open (IN, $ARGV[1]);
$/ = ">";
while (<IN>) {
    s/(?=(\S+):)/$name{$1}:/;
    print;
}

print join ("", values %longest);

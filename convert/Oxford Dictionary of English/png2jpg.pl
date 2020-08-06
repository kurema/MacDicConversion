while(my $t=<STDIN>){
$t=~ s/.png"/.jpg"/g;
print $t;
}

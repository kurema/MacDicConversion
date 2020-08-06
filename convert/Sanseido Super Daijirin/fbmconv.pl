while(my $t=<STDIN>){
$t=~ s/<a href="x-dictionary:r:fbm_AccentPatterns">/<a href="fbm.html#fbm_AccentPatterns">/g;
print $t;
}
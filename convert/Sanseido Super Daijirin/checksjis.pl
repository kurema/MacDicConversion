while(my $t = <STDIN>){
if($t=~ /([‡@‡A‡B‡C‡D‡E‡F‡G‡H‡I‡J‡K‡L‡M‡N‡O‡P‡Q‡R‡S‡T‡U‡V‡W‡X‡Y‡Z‡[‡\‡]‡_‡`‡a‡b‡c‡d‡e‡f‡g‡h‡i‡j‡k‡l‡m‡n‡o‡p‡q‡r‡s‡t‡u‡~‡€‡‡‚‡ƒ‡„‡…‡†‡‡‡ˆ‡‰‡Š‡‹‡Œ‡‡Ž‡àßç‡“ãÛÚ‡˜‡™æ¿¾])/){
print "$1";
}
}
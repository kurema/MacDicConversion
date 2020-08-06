use Lingua::KO::Romanize::Hangul;
use Encode;
use utf8;

my $conv = Lingua::KO::Romanize::Hangul->new();

while(my $text=<STDIN>){
my $roman = $conv->char( $hangul );
$text=~ s/<gaijiMap unicode="#x([0-9a-fA-F]+)" ebcode="([0-9a-fA-F]+)" \/>/<gaijiMap unicode="#x$1" ebcode="$2" alt="convRoman($1)"\/>/g;
$text=~ s/convRoman\(([0-9a-fA-F]+)\)/&conv($1)/eg;
$text=~ s/ alt=""//g;
print $text;
}

sub conv{
my $hangul = chr(hex($_[0]));
return $conv->char( $hangul );
}

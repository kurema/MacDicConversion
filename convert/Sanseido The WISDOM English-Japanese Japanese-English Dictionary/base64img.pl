use MIME::Base64;

my $dir="./base64/";

my $cnt=0;
while(my $text= <STDIN>){
while($text=~ /<a href="data:([^;]*);base64,([a-zA-Z0-9\+\/\=]*)">/){
my $ext=".png";
my $extlink=".bmp";

my $mimetype=$1;
my $encoded=$2;

if($mimetype=="image/png"){$ext=".png";$extlink=".bmp";}
elsif($mimetype=="image/jpeg"){$ext=".jpg";$extlink=".jpg";}

my $fn=$dir.$cnt.$ext;
&saveFile($fn,decode_base64($encoded));

my $fnlink=$dir.$cnt.$extlink;
$text=~ s/<a href="data:([^;]*);base64,([^"]*)">(.*?)<\/a>/<img src="$fnlink" class="inline" \/>$3/;

$cnt++;
}
print $text;
}

sub saveFile{
	open DATA,">".$_[0];
	binmode DATA;
	flock(DATA, LOCK_EX);
	print DATA $_[1];
	flock(DATA, LOCK_NB); 
	close DATA;
	$fileCache{$_[0]}=$_[1];
}
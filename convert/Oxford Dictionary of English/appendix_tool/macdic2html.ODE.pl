$target="utf8.html";
$html="";
$directOutputCount=0;

unlink($target);
open OUTPUT,">>".$target;

print OUTPUT "<html><head><title></title></head>\n<body>\n<dl>\n";
$i=0;
while(-e ("./out/".$i.".xml")){
	print $i."\n";
	loadXML(loadFile("./out/".$i.".xml"));
	$i++;}
print OUTPUT "</dl></body></html>";

sub loadXML{
	$html="";
	my($text)=$_[0];
	$text=~ s/\<d:entry [^\<\>]*?id\=\"([^\<\>\"]+?)\"[^\<\>]*?\>(.+?)<\/d:entry\>/loadEntry($2,$1)/seg;
	print OUTPUT $html;
}

sub loadEntry{
	my($text)=$_[0];
	my($title)="";
	my($hyouki)="";
	my($body)="";
	my(@keysHyouki);
	my($id)=$_[1];
	my($appendix)=0;

if($id eq "fbm_EditorialStaff"){
$directOutputCount=1;
}
if($directOutputCount!=0){
saveFile($directOutputCount.".html",$id."\n".$text);
$directOutputCount++;
return "";
}

	if($text=~ /\<html[^\<\>]*?\>/){
		$text=~ s/\<br\s?\/?\>/\(\#\#ENTER\#\#\)/g;

#		$text=~ /\<[^\<\>]+\>[^\<\>]*?\s*([a-zA-Z\s\'\"]+)\s*[^\<\>]*?\<[^\<\>]+\>/;
		$text=~ /\>[^\<\>]*?\s*([^\<\>\n\r\t\s][^\<\>]*)\s*[^\<\>]*?\</;
		my($tmp)=$1;
		$tmp=~ s/\(\#\#ENTER\#\#\)//g;
		while($tmp=~ /\s\s/){$tmp=~ s/\s\s/ /g;}
		$title="\*".$tmp;
		push(@keysHyouki,"\<key type\=\"表記\"\>APPENDIX<\/key\>\n");
		push(@keysHyouki,"\<key type\=\"表記\"\>$tmp<\/key\>\n");


		$text=~ s/\<span[^\<\>]+?style=\"[^\<\>]*?font-weight\: bold[^\<\>]*?\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/\(\#\#BEGIN BOLD\#\#\)$1\(\#\#END BOLD\#\#\)/g;
		$text=~ s/\<span[^\<\>]+?style=\"[^\<\>]*?font-style\: italic[^\<\>]*?\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/\(\#\#BEGIN ITALIC\#\#\)$1\(\#\#END ITALIC\#\#\)/g;
		$text=~ s/\<\/div\>|\<\/p\>/\(\#\#ENTER\#\#\)/g;
		}

	$text=~ s/\<span [^\<\>]*?\/\>//g;

	$text=~ s/\<i\>/\(\#\#BEGIN ITALIC\#\#\)/g;
	$text=~ s/\<\/i\>/\(\#\#END ITALIC\#\#\)/g;
	$text=~ s/\<sup\>/\(\#\#BEGIN SUP\#\#\)/g;
	$text=~ s/\<\/sup\>/\(\#\#END SUP\#\#\)/g;
	$text=~ s/\<sub\>/\(\#\#BEGIN SUB\#\#\)/g;
	$text=~ s/\<\/sub\>/\(\#\#END SUB\#\#\)/g;
	$text=~ s/\<b\>/\(\#\#BEGIN BOLD\#\#\)/g;
	$text=~ s/\<\/b\>/\(\#\#END BOLD\#\#\)/g;
	$text=~ s/\<title\>/\(\#\#BEGIN H1\#\#\)/g;
	$text=~ s/\<\/title\>/\(\#\#END H1\#\#\)/g;
	$text=~ s/\<strong\>/\(\#\#BEGIN STRONG\#\#\)/g;
	$text=~ s/\<\/strong\>/\(\#\#END STRONG\#\#\)/g;
	$text=~ s/\<em\>/\(\#\#BEGIN EM\#\#\)/g;
	$text=~ s/\<\/em\>/\(\#\#END EM\#\#\)/g;
	$text=~ s/\<table\s?[^\<\>]*?\>/\(\#\#BEGIN table\#\#\)/g;
	$text=~ s/\<\/table\>/\(\#\#END table\#\#\)/g;
	$text=~ s/\<caption\s?[^\<\>]*?\>/\(\#\#BEGIN caption\#\#\)/g;
	$text=~ s/\<\/caption\>/\(\#\#END caption\#\#\)/g;
	$text=~ s/\<tr\s?[^\<\>]*?\>/\(\#\#BEGIN tr\#\#\)/g;
	$text=~ s/\<\/tr\>/\(\#\#END tr\#\#\)/g;
	$text=~ s/\<th\s?[^\<\>]*?\/\>/\(\#\#BEGIN th\#\#\)\(\#\#END th\#\#\)/g;
	$text=~ s/\<th\s?[^\<\>]*?\>/\(\#\#BEGIN th\#\#\)/g;
	$text=~ s/\<\/th\>/\(\#\#END th\#\#\)/g;
	$text=~ s/\<td\s?[^\<\>]*?\>/\(\#\#BEGIN td\#\#\)/g;
	$text=~ s/\<\/td\>/\(\#\#END td\#\#\)/g;

	$text=~ s/\<img [^\<\>]*src\=[\"\']([^\<\>]+?)\.png[\"\'][^\<\>]*alt=\"([^\>\<]*)\"\/?\>/\(\#\#ENTER\#\#\)\(\#\#BEGIN a $1\.jpg\#\#\)$2\(\#\#END a\#\#\)\(\#\#ENTER\#\#\)/g;
	$text=~ s/\<img [^\<\>]*src\=\"([^\<\>]+?)\.[a-zA-Z]{1,3}\"[^\<\>]*\/?\>/\(\#\#ENTER\#\#\)\(\#\#BEGIN LINK $1\.jpg\#\#\)画像\(\#\#END LINK\#\#\)\(\#\#ENTER\#\#\)/g;
	$text=~ s/<a href=\"x-dictionary\:r\:([^\:]+?)\:[^\"]+\"[^\<\>]*?\/>/\(\#\#BEGIN LINK \#$1\#\#\)$2\(\#\#END LINK\#\#\)/g;
	$text=~ s/<a href=\"x-dictionary\:r\:([^\:]+?)\:[^\"]+\"[^\<\>]*?>(.+?)<\/a>/\(\#\#BEGIN LINK \#$1\#\#\)$2\(\#\#END LINK\#\#\)/g;
	
	$text=~ s/(\<([a-z]+?) [^\<\>]*?\>)/$2 eq "span"?$1:""/eg;
	$text=~ s/(\<\/?([a-z]+?)\>)/$2 eq "span"?$1:""/eg;

	while($text=~ /\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/){
		my($class)=$1;
		if($class eq "hw" or $class eq "headword"){
			$title.=$2;
			my($tmp)=$2;
			$tmp=~ s/\<[^\<\>]+?\>//g;
			push(@keysHyouki,"\<key type\=\"表記\"\>".$tmp."<\/key\>\n");
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>//;
			}
		elsif($class eq "hm"){
			$title.="\(\#\#BEGIN SUP\#\#\)".$2."\(\#\#END SUP\#\#\)";
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>//;
			}
		elsif($class eq "ex" or $class eq "usage" or $class eq "sense" or $class eq "para" or $class=~ /List$/ or $class=~ /Block$/){
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/\(\#\#ENTER\#\#\)$2/;
			}
		elsif($class=~ /Grp$/){
#			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/$1 eq "pronGrp" or $1 eq "infGrp" or $1 eq "varGrp"?$2:"\(\#\#ENTER\#\#\)".$2/e;
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/$1 eq "xrefGrp"?"【".$2."】":$2/e;
			}
		elsif( $class eq "lbl"){
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/$2 /;
			}
		elsif( $class eq "x"){
			my($tmp)=$2;
			$tmp=~ s/[\s\-\']+//g;
			$tmp=~ tr/A-Z/a-z/;
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/\(\#\#BEGIN LINK \#$tmp\#\#\)$2\(\#\#END LINK\#\#\)/;
			}
		elsif($class eq "italic"){
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/\(\#\#BEGIN ITALIC\#\#\)$2\(\#\#END ITALIC\#\#\)/;
			}
		elsif($class eq "bold"){
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/\(\#\#BEGIN BOLD\#\#\)$2\(\#\#END BOLD\#\#\)/;
			}
		else{
			$text=~ s/\<span [^\<\>]*?class=\"([^\<\>\"]+?)\"[^\<\>]*?\>([^\<\>]*?)\<\/span\>/$2/;
			}
		}
	$text=~ s/\<[^\<\>]+?\>//g;


#	$title=replaceInvalidChar($title);
#	$text=replaceInvalidChar($text);
#	$hyouki=replaceInvalidChar($hyouki);
#	$body=replaceInvalidChar($body);
	
	while($text=~ /\(\#\#ENTER\#\#\)[\s\t\n\r]*\(\#\#ENTER\#\#\)/){
		$text=~ s/\(\#\#ENTER\#\#\)[\s\t\n\r]*\(\#\#ENTER\#\#\)/\(\#\#ENTER\#\#\)/g;
		}
	$text=~ s/^\(\#\#ENTER\#\#\)//;
	$text=~ s/\(\#\#ENTER\#\#\)$//;

	$html.="<dt id=\"".$id."\">".$title."".$hyouki.""."<\/dt>\n".join("",@keysHyouki)." <dd>".$text."<\/dd>\n";

	$html=~ s/\(\#\#ENTER\#\#\)/\<br\>/g;
	$html=~ s/\(\#\#BEGIN ITALIC\#\#\)/\<i\>/g;
	$html=~ s/\(\#\#END ITALIC\#\#\)/\<\/i\>/g;
	$html=~ s/\(\#\#BEGIN SUP\#\#\)/\<sup\>/g;
	$html=~ s/\(\#\#END SUP\#\#\)/\<\/sup\>/g;
	$html=~ s/\(\#\#BEGIN SUB\#\#\)/\<sub\>/g;
	$html=~ s/\(\#\#END SUB\#\#\)/\<\/sub\>/g;
	$html=~ s/\(\#\#BEGIN BOLD\#\#\)/\<b\>/g;
	$html=~ s/\(\#\#END BOLD\#\#\)/\<\/b\>/g;
	$html=~ s/\(\#\#BEGIN H1\#\#\)/\<h1\>/g;
	$html=~ s/\(\#\#END H1\#\#\)/\<\/h1\>/g;
	$html=~ s/\(\#\#BEGIN STRONG\#\#\)/\<strong\>/g;
	$html=~ s/\(\#\#END STRONG\#\#\)/\<\/strong\>/g;
	$html=~ s/\(\#\#BEGIN EM\#\#\)/\<em\>/g;
	$html=~ s/\(\#\#END EM\#\#\)/\<\/em\>/g;
	$html=~ s/\(\#\#BEGIN LINK ([^\<\>]+?)\#\#\)/\<a href=\"$1\"\>/g;
	$html=~ s/\(\#\#END LINK\#\#\)/\<\/a\>/g;
	$html=~ s/\(\#\#BEGIN IMG ([^\#]+?)\#\#\)/\<img src=\"$1\" class\=\"inline\"\>/g;
	$html=~ s/\(\#\#BEGIN ([a-z]+?)\#\#\)/\<$1\>/g;
	$html=~ s/\(\#\#END ([a-z]+?)\#\#\)/\<\/$1\>/g;
}


sub elimTag{
	my($in)=$_[0];
	$in=~ s/\<(.+?)\>//g;
	return $in;
}

#_________________________________________________
sub addFile{
	open DATA,">>".$_[0];
	flock(DATA, LOCK_EX);
	print DATA $_[1];
	flock(DATA, LOCK_NB); 
	close DATA; 
}

sub loadFile{
	if ( exists($fileCache{$_[0]}) ) {
		return $fileCache{$_[0]}
	}else{
		local(@temp);
		open DATA,$_[0];
		flock(DATA, LOCK_EX);
		@temp = <DATA>;
		print <DATA>;
		flock(DATA, LOCK_NB); 
		close DATA;
		$fileCache{$_[0]}=join "",@temp;
		return join "",@temp;
	}
}

sub saveFile{
	open DATA,">".$_[0];
	flock(DATA, LOCK_EX);
	print DATA $_[1];
	flock(DATA, LOCK_NB); 
	close DATA;
	$fileCache{$_[0]}=$_[1];
}
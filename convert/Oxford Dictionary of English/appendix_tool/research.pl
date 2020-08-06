$i=0;
while(-e ("./out/".$i.".xml")){
	print $i."\n";
	loadXML(loadFile("./out/".$i.".xml"));
	$i++;}

sub loadXML{
	$html="";
	my($text)=$_[0];
	$text=~ s/class="([^"]*)"/AddIndex($1)/eg;
	$text=~ s/<([a-zA-Z\:]+)[\s\>\/]/AddTagIndex($1)/eg;
}

$target="Classes.txt";
unlink $target;
open CLASSINDEX,">>".$target;
$result="";
foreach my $key (keys %Index){
	$result.=$key."\t".$Index{$key}."\n";
}
print CLASSINDEX $result;

$target="Tags.txt";
unlink $target;
open TAGINDEX,">>".$target;
$result="";
foreach my $key (keys %TagIndex){
	$result.=$key."\t".$TagIndex{$key}."\n";
}
print TAGINDEX $result;

sub AddIndex{
	$Index{$_[0]}++;
}

sub AddTagIndex{
	$TagIndex{$_[0]}++;
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
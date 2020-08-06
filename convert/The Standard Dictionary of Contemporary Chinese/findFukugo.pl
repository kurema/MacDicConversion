print "<?xml version=\"1.0\" encoding=\"Shift_JIS\"?>\n<complex>\n<group name=\"分野検索\">\n";

%keys;
while(my $t=<STDIN>){
$t=~ s/<key type="複合" name="([^"]*)">([^\<]*)<\/key>/&CountFukugo($1,$2)/eg;
}

%category;
foreach my $key (sort {$a cmp $b} (keys(%keys))){
my @temp=split(/\"/,$key,2);
if($keys{$key}>=0){
$category{$temp[0]}.="<!-- ".$keys{$key}." -->";
$category{$temp[0]}.="<subcategory name=\"".$temp[1]."\" \/>\n";
}
}

foreach my $key (sort {$a cmp $b} (keys(%category))){
print "<category name=\"".$key."\">\n";
print $category{$key};
}
print "</category>\n<keyword name=\"キーワード1\" />\n</group>\n</complex>\n";

sub CountFukugo{
my $name=$_[0];
my $value=$_[1];
$keys{$name."\"".$value}++;
}

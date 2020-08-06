FontDumpK ü‡ÉSÉVÉbÉN out.html main.nob64.html -map=map.map
mkdir base64
perl base64img.pl < main.nob64.html >main.b64.html
perl fbmconv.pl < main.b64.html >main.html
imageConvert.exe base64 *.png
mkdir table
perl table.pl
table2image.exe table imgt
perl findFukugo.pl <main.html>complex.xml
"C:\Program Files (x86)\EBStudio\EBStudio.exe" -e book.ebs

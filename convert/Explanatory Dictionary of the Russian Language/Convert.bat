MacDic2html.exe
FontDumpK ���S�V�b�N out.html main.nob64.html -map=map.map
perl base64img.pl < main.nob64.html >main.html
mkdir table
perl table.pl
table2image.exe table imgt
perl findFukugo.pl <main.html>complex.xml
pause

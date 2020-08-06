MacDic2html.exe
FontDumpK ŸàƒSƒVƒbƒN out.html main.wob64.html -map=map.map
mkdir base64
perl base64img.pl < main.wob64.html > main.html
mkdir table
perl table.pl
table2image.exe table imgt
pause
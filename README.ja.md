# MacDicConversion
## 使い方
日本語でこれを読んでいる方はEBStudioの利用をお勧めします。
### EBStudio
1. ``Body.data``を``unzip/``に配置する。
2. ``convert.bat``を実行。``unzip/out/``に大量のhtmlファイルが出来ます。
3. ``unzip/out/``を``convert/辞書名/``に移動します。  
該当しなければ適当なフォルダをコピーして、そこに入れます。``Arkadas Turkce Sozluk``とかは標準的なのでそのあたりで。
4. ``DefaultStyle.css``と``Images/``もそのフォルダにコピーします。
5. ``convert.bat``を実行します。
6. ``readme.txt``に何か記載があれば、手作業などが必要な場合があります。
7. EBStudioで``*.ebs``を開いて変換してください。

ちなみに``Convert-encode.bat``は時間のかかる``MacDic2html.exe``作業を省略するためのバッチファイルです。

## EBStudioについて
EBStudioはhishida様が作成したEPWing作成ツールです。神ツールです。  
このツールを作成した当時はありませんでしたが、現時点はUTF-8対応の[EBStudio2](http://ebstudio.info/manual/EBStudio2/EBStudio2.html)がリリースされています。  
ですから、``convert.bat``内の``FontDumpK``の行はスキップして(本来別ファイルを作成するのでコピーかリネームをして)、UTF-8のまま入力した方が良いかもしれません。

## 免責
ツールを作成したのはずいぶん前なので正直いろんなことを忘れています。ご容赦ください。

著作権や利用規約などは各自の責任で判断して下さい。責任は負えません。そういうライセンスですし。

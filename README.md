# MacDicConversion
[日本語](README.ja.md)
## How To
### Basic
If you don't know what [EBStudio](http://ebstudio.info/home/EBStudio.html) is ...

1. copy ``Body.data`` from somewhare to ``unzip/``
2. run convert.bat  
``unzip/out/`` contains bunch of html files. But it may need to be processed. 
3. cut ``unzip/out/`` to ``convert/*/``.
4. copy ``DefaultStyle.css`` and ``Images/`` (if exist) to ``convert/*/``
5. run ``MacDic2html.exe``.
6. You get ``out.html``.

### New dictionary
If you couldn't find matching folder in ``convert/`` in **Basic**

3. make a directory and name it ``dictionary/`` (or whatever).
4. copy ``MacDic2html.exe`` and ``unzip/out/`` to ``dictionary/`` from any of ``convert/*/``.
5. make ``DictionaryStyle.css`` in ``dictionary/``.
6. edit ``DictionaryStyle.css``.

it will typically be
```
span.hg{headWordGroup:true;}
span.hw{key:headword;}
span.hg span.hv{key:headword;}
```
It depends on html structure to convert, so check some files in ``/out/``

7. go to #4 of **Basic**

### EBStudio
If you use [EBStudio](http://ebstudio.info/home/EBStudio.html) ...

1. copy ``Body.data`` from somewhare to ``unzip/``
2. run convert.bat  
``unzip/out/`` contains bunch of html files. But it may need to be processed. 
3. cut ``unzip/out/`` to ``convert/*/``.
4. copy ``DefaultStyle.css`` and ``Images/`` (if exist) to ``convert/*/``
5. run ``convert.bat``.
6. you may need extra work. read ``readme.txt``(Japanese) if exist.
7. open EBStudio and convert!



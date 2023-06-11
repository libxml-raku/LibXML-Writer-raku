[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML Module]](https://libxml-raku.github.io/LibXML-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-raku/Writer)
 :: [Document](https://libxml-raku.github.io/LibXML-raku/Writer/Document)

Synopsis
--------

```raku
use LibXML::Document;
use LibXML::Writer::Document;
my LibXML::Document $doc .= new;
my LibXML::Writer::Document:D $writer .= new: :$doc;
$writer.write: '#xml' => ['elem' => ['text']];
say $writer.doc.Str;
# <?xml version="1.0" encoding="UTF-8"?>
# <elem>text</elem>
```


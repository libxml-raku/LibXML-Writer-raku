[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)
 :: [Document](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Document)

class LibXML::Writer::Document
------------------------------

LibXML document construction

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

Description
-----------

This output class allows a document to be constructed via [LibXML::Writer](https://libxml-raku.github.io/LibXML-Writer-raku).


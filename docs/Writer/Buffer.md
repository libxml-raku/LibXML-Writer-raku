[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)
 :: [Buffer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Buffer)

class LibXML::Writer::Buffer
----------------------------

In-memory buffer construction

Synopsis
--------

```raku
use LibXML::Writer::Buffer;
my LibXML::Writer::Buffer:D $writer .= new;
$writer.write: 'elem' => ['text'];
say $writer.Str;  # <elem>text</elem>
say $writer.Blob; # Buf[uint8]:0x<3C 65 6C ...>
```

Description
-----------

This output class writes to an in-memory buffer.


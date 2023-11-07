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
use LibXML::Writer::Buffer; # String or buffer output
my LibXML::Writer::Buffer:D $writer .= new;

$writer.startElement('Test');
$writer.writeAttribute('id', 'abc123');
$writer.writeText('Hello world!');
$writer.endElement();
say $writer.Str;  # <Test id="abc123">Hello world!</Test>
say $writer.Blob; # Buf[uint8]:0x<3C 54 65 ...>

# XML::Writer compatibility
say LibXML::Writer::Buffer.serialize: 'elem' => ['text'];
# <elem>text</elem>
```

Description
-----------

This class writes to an in-memory buffer. The final XML document can then be rendered using the `Str` or `Blob` methods.

A class-level `serialize method is also provided for compatibility with [XML::Writer](https://raku.land/github:masak/XML::Writer).


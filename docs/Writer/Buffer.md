[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)
 :: [Buffer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Buffer)

Synopsis
--------

```raku
use LibXML::Writer::Buffer;
my LibXML::Writer::Buffer:D $writer .= new;
$writer.write: 'elem' => ['text'];
say $writer.Str;  # <elem>text</elem>
say $writer.Blob; # Buf[uint8]:0x<3C 65 6C ...>
```

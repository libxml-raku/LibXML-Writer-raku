[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)
 :: [File](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/File)

class LibXML::Writer::File
--------------------------

Stream to an external file

Synopsis
--------

```raku
use File::Temp;
my (Str:D $file) = tempfile();
my LibXML::Writer::File $writer .= new: :$file;

$writer.startDocument();
$writer.startElement('Baz');
$writer.endElement;
$writer.endDocument;
$writer.close;
my $io = $file.IO;
say $io.lines.join;  # <?xml version="1.0" encoding="UTF-8"?><Baz/>;
```

Description
-----------

This output class enables efficient low-memory streaming of an XML document directly to a file.


LibXML-Writer-raku
=======

Synopsis
-------
```raku
use LibXML::Writer::Buffer; # String or buffer output
my LibXML::Writer::Buffer:D $writer .= new;

$writer.startDocument( :enc<UTF-8> , :version<1.0>, :standalone);
$writer.startElement('Test');
$writer.writeAttribute('id', 'abc123');
$writer.writeText('Hello world!');
$writer.endElement();
$writer.endDocument();
say $writer.Str;
# <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
# <Test id="abc123">Hello world!</Test>

# write an AST fragment

$writer .= new;
$writer.write: "Test" => [:id<abc123>, 'Hello world!'];
say $writer.Str;
# <Test id="abc123">Hello world!</Test>
```

Description
------

This module binds to the libxml2 Writer interface. It can be used to construct full XML
documents or XML fragments.

It offers:
- an alternative to the W3C DOM for constructing XML documents
- the ability to stream to files, buffers or strings without the need to create an intermediate XML document

The API is documented in [LibXML::Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)

Classes
----

This module has several output classes:

  * [LibXML::Writer::Buffer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Buffer) - String or buffer output

  * [LibXML::Writer::Document](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Document) - Construction of LibXML Documents

  * [LibXML::Writer::Node](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Node) - Construction of Document Sub-trees or Fragments

  * [LibXML::Writer::PushParser](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/PushParser) - Construction of LibXML documents via LibXML::PushParser

  * [LibXML::Writer::File](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/File) - Direct file output





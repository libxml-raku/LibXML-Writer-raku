[![Actions Status](https://github.com/libxml-raku/LibXML-Writer-raku/workflows/test/badge.svg)](https://github.com/libxml-raku/LibXML-Writer-raku/actions)

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

Classes
----

This module has several output classes:

### `LibXML::Writer::Buffer` 

For output to a string or buffer.

### `LibXML::Writer::Document`

For construction of LibXML Documents

### `LibXML::Writer::PushParser`

For construction of LibXML Documents via `LibXML::PushParser`

### `LibXML::Writer::File`

For output directly to a file


Methods
----

### Documents

#### startDocument
#### endDocument

### Elements

#### startElement
#### endElement
#### writeElement

### Attributes

#### startAttribute
#### endAttribute
#### writeAttribute

### Content

#### writeText
#### writeCDATA
#### writePI
#### writeComment
#### writeRaw

### Name-Spaces

#### startElementNS
#### writeElementNS
#### writeAttributeNS

### DTD'S

#### writeDTD
#### startDTD
#### endDTD
#### startDTDElement
#### endDTDElement
#### writeDTDElement
#### writeDTDAttList
#### startDTDEntity
#### endDTDEntity
#### writeDTDInternalEntity
#### writeDTDExternalEntity
#### writeDTDNotation

### AST

#### write

### Not yet implemented





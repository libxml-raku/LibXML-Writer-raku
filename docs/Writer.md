[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)

class LibXML::Writer
--------------------

Interface to libxml2 stream writer

use LibXML::Writer::Buffer; # write to a string

### method have-writer

```raku
method have-writer() returns Mu
```

Ensure libxml2 has been compiled with the text-writer enabled

Methods
-------

### Document Methods

#### startDocument

#### endDocument

### Element Methods

#### startElement

#### endElement

#### writeElement

### Attribute Methods

#### startAttribute

#### endAttribute

#### writeAttribute

### Content Methods

#### writeText

#### writeCDATA

#### writePI

#### writeComment

#### writeRaw

### Name-Space Methods

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

### AST Methods

#### write

### Not yet implemented Methods


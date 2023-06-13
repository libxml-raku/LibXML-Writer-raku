[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)

class LibXML::Writer
--------------------

Interface to libxml2 stream writer

use LibXML::Writer::Buffer; # write to a string

Methods
-------

### method have-writer

```raku
method have-writer() returns Bool
```

Ensure libxml2 has been compiled with the text-writer enabled

### Indentation

### method setIndented

```raku
method setIndented(
    Bool:D(Any):D $indented = Bool::True
) returns Mu
```

enable or disable indentation

### Document Methods

### method startDocument

```raku
method startDocument(
    Str :$version,
    Str:D :$!enc = "UTF-8",
    Bool :$standalone
) returns Mu
```

Starts the document and writes the XML declaration

### method endDocument

```raku
method endDocument() returns Mu
```

Closes any open elements or attributes and finishes the document

### Element Methods

### method startElement

```raku
method startElement(
    Str $name where { ... }
) returns Mu
```

Writes the specified start tag

### method startElementNS

```raku
method startElementNS(
    Str $local-name where { ... },
    Str :$prefix,
    Str :$uri
) returns Mu
```

Writes the specified start tag and associates it with the given namespace and prefix

### method endElement

```raku
method endElement() returns Mu
```

Closes the current element

### method writeElement

```raku
method writeElement(
    Str $name where { ... },
    Str $content?
) returns Mu
```

Writes a single element; Either empty or with the given content

### method writeElementNS

```raku
method writeElementNS(
    Str $local-name where { ... },
    Str $content = "",
    Str :$prefix,
    Str :$uri
) returns Mu
```

Writes a single element and associates it with the given namespace and prefix

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


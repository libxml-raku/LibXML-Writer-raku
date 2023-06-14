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

Enable or disable indentation

### method setIndentString

```raku
method setIndentString(
    Str:D $indent
) returns Mu
```

Set indentation text

### method setQuoteChar

```raku
method setQuoteChar(
    Str:D $quote
) returns Mu
```

Set character for quoting attributes

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

Writes a single element with an associated namespace and prefix

### method writeAttribute

```raku
method writeAttribute(
    Str $name where { ... },
    Str $content
) returns Mu
```

Writes an XML attribute

### method writeAttributeNS

```raku
method writeAttributeNS(
    Str $local-name where { ... },
    Str $content,
    Str :$prefix,
    Str :$uri
) returns Mu
```

Writes an XML attributet with an associated namespace and prefix

### method writeComment

```raku
method writeComment(
    Str:D $content
) returns Mu
```

Writes an XML comment

### method writeText

```raku
method writeText(
    Str:D $content
) returns UInt
```

Writes text content with escaping and encoding

```raku
$bytes-written = $writer.writeText: 'A&B'; # output: A&amp;B
```

### method writeCDATA

```raku
method writeCDATA(
    Str:D $content
) returns UInt
```

Writes CDATA formatted text content

```raku
$bytes-written = $writer.writeCDATA: 'A&B'; # output: <![CDATA[A&B]]>
```

### multi method writeRaw

```raku
multi method writeRaw(
    Str:D $content
) returns Mu
```

Writes an encoded string

### multi method writeRaw

```raku
multi method writeRaw(
    Blob[uint8]:D $content,
    Int $len where { ... } = Code.new
) returns Mu
```

Writes a preencoded buffer directly

### method writePI

```raku
method writePI(
    Str $name where { ... },
    Str $content
) returns Mu
```

Wries an XML Processing Instruction

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


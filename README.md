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

Writes the specified start tag and associates it with the given name-space and prefix

### method endElement

```raku
method endElement() returns Mu
```

Closes the current element

### method writeAttribute

```raku
method writeAttribute(
    Str $name where { ... },
    Str $content
) returns Mu
```

Writes an XML attribute, within an element

### method writeAttributeNS

```raku
method writeAttributeNS(
    Str $local-name where { ... },
    Str $content,
    Str :$prefix,
    Str :$uri
) returns Mu
```

Writes an XML attribute with an associated name-space and prefix, within an element

### method writeElement

```raku
method writeElement(
    Str $name where { ... },
    Str $content?
) returns Mu
```

Writes an atomic element; Either empty or with the given content

### method writeElementNS

```raku
method writeElementNS(
    Str $local-name where { ... },
    Str $content = "",
    Str :$prefix,
    Str :$uri
) returns Mu
```

Writes an atomic element with an associated name-space and prefix

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

Writes a string, with encoding

### multi method writeRaw

```raku
multi method writeRaw(
    Blob[uint8]:D $content,
    Int $len where { ... } = Code.new
) returns Mu
```

Writes a pre-encoded buffer directly

### method writePI

```raku
method writePI(
    Str $name where { ... },
    Str $content
) returns Mu
```

Writes an XML Processing Instruction

### DTD Methods

### method writeDTD

```raku
method writeDTD(
    Str $name where { ... },
    Str :$public-id,
    Str :$system-id,
    Str :$subset
) returns Mu
```

Writes an atomic XML DOCTYPE Definition (DTD)

### method startDTD

```raku
method startDTD(
    Str $name where { ... },
    Str :$public-id,
    Str :$system-id
) returns Mu
```

Starts an XML DOCTYPE Definition (DTD)

The methods below can then be used to add definitions for DTD Elements, Attribute Lists, Entities and Notations, before calling `endDTD`.

### method endDTD

```raku
method endDTD() returns Mu
```

Ends an XML DOCTYPE Definition (DTD)

### method startDTDElement

```raku
method startDTDElement(
    Str $name where { ... }
) returns Mu
```

Starts an Element definition with an XML DTD

### method endDTDElement

```raku
method endDTDElement() returns Mu
```

Ends an XML DTD element definition

### method writeDTDElement

```raku
method writeDTDElement(
    Str $name where { ... },
    Str:D $content = "(EMPTY*)"
) returns Mu
```

Writes an Element declaration within an XML DTD

### method writeDTDAttlist

```raku
method writeDTDAttlist(
    Str $name where { ... },
    Str $content
) returns Mu
```

Writes an Attribute List declaration within an XML DTD

### method startDTDEntity

```raku
method startDTDEntity(
    Str $name where { ... },
    Int :$pe
) returns Mu
```

Starts an entity definition within an XML DTD

### method endDTDEntity

```raku
method endDTDEntity() returns Mu
```

Ends an XML DTD Entity definition

### method writeDTDInternalEntity

```raku
method writeDTDInternalEntity(
    Str $name where { ... },
    Str:D $content,
    Int :$pe
) returns Mu
```

Writes an Internal Entity definition within an XML DTD

### method writeDTDExternalEntity

```raku
method writeDTDExternalEntity(
    Str $name where { ... },
    Str :$public-id,
    Str :$system-id,
    Str :$ndata,
    Int :$pe
) returns Mu
```

Writes an external entity definition within an XML DTD

### method writeDTDNotation

```raku
method writeDTDNotation(
    Str $name where { ... },
    Str :$public-id,
    Str :$system-id
) returns Mu
```

Writes a notation definition within an XML DTD

### method write

```raku
method write(
    $ast
) returns Mu
```

Write an AST struct

### method flush

```raku
method flush() returns Mu
```

Flush an buffered XML

### method close

```raku
method close() returns Mu
```

Finish writing XML. Flush output and free the native XML Writer


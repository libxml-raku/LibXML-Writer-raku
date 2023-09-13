[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)
 :: [Node](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Node)

Description
-----------

This class is used to write sub-trees; stand-alone or within a containing document.

Synopsis
--------

```raku
use LibXML::Document;
use LibXML::Element;
use LibXML::Writer::Node;
my LibXML::Document $doc .= new;
    $doc.root = $doc.createElement('Foo');
    my LibXML::Element $node = $doc.root.addChild:  $doc.createElement('Bar');
    my LibXML::Writer::Node $writer .= new: :$node;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
say $writer.Str;
say $doc.Str;
# <?xml version="1.0" encoding="UTF-8"?>
# <Foo><Bar><Baz/></Bar></Foo>
```


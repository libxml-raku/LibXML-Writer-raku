[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)
 :: [Node](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/Node)

class LibXML::Writer::Node
--------------------------

LibXML document fragment/sub-tree construction

Synopsis
--------

```raku
use LibXML::Document;
use LibXML::Element;
use LibXML::Writer::Node;
my LibXML::Document $doc .= new;
# concurrent sub-tree construction
my LibXML::Element @twigs = (1.10).hyper.map: {
    my LibXML::Element $node = $doc.createElement('Bar');
    my LibXML::Writer::Node $writer .= new: :$node;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    $writer.node;
}
my $root = $doc.createElement('Foo');
$root.addChild($_) for @twigs;
$doc.root = $root;
say $writer.Str;
say $doc.Str;
# <?xml version="1.0" encoding="UTF-8"?>
# <Foo><Bar><Baz/></Bar>...</Foo>
```

Description
-----------

This class is used to write sub-trees; stand-alone or within a containing document.


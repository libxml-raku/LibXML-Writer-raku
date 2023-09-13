use Test;
use LibXML::Element;
use LibXML::Writer::Node;

plan 2;

subtest 'nested child contruction', {
    my LibXML::Document $doc .= new;
    $doc.root = $doc.createElement('Foo');
    my LibXML::Element $node = $doc.root.addChild:  $doc.createElement('Bar');
    my LibXML::Writer::Node $writer .= new: :$node;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    is $writer.doc.root.Str, '<Foo><Bar><Baz/></Bar></Foo>';
}

subtest 'late root attachment', {
    my LibXML::Element $node .= new('Foo');
    my LibXML::Document $doc .= new;
    my LibXML::Writer::Node $writer .= new: :$node, :$doc;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    is $writer.node.Str, '<Foo><Baz/></Foo>';
    $doc.root = $node;
    is $writer.doc.root.Str, '<Foo><Baz/></Foo>';
}


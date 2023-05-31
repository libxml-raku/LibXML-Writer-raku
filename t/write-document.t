use Test;
use LibXML::Document;
use LibXML::Element;
use LibXML::Writer::Document;

plan 3;

unless LibXML::Writer::Document.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

subtest 'constructed root', {
    my LibXML::Document $doc .= new;
    my LibXML::Writer::Document:D $writer .= new: :$doc;
    ok $writer.raw.defined;
    $writer.startDocument();
    $writer.startElement('Foo');
    $writer.endElement;
    $writer.endDocument;
    is $writer.doc.root.Str, '<Foo/>';
}

subtest 'nested child contruction', {
    my LibXML::Document $doc .= new;
    $doc.root = $doc.createElement('Foo');
    my LibXML::Element $node = $doc.root.addChild:  $doc.createElement('Bar');
    my LibXML::Writer::Document $writer .= new: :$node;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    is $writer.doc.root.Str, '<Foo><Bar><Baz/></Bar></Foo>';
}

subtest 'late root attachment', {
    my LibXML::Element $node .= new('Foo');
    my LibXML::Document $doc .= new;
    my LibXML::Writer::Document $writer .= new: :$node, :$doc;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    is $writer.node.Str, '<Foo><Baz/></Foo>';
    $doc.root = $node;
    is $writer.doc.root.Str, '<Foo><Baz/></Foo>';
}


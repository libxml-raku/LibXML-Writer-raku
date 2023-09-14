use Test;
use LibXML::Element;
use LibXML::Writer::Node;

plan 3;

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

subtest 'concurrent document writers', {
    my LibXML::Document $doc .= new;
    my atomicint $ok = 0;
    my LibXML::Element @elems = (1..20).hyper(:batch(1)).map: {
        my LibXML::Element $node = $doc.createElement('Foo');
        my LibXML::Writer::Node $writer .= new: :$node, :$doc;
        $writer.startDocument();
        $writer.startElement('Baz');
        $writer.writeText('This is Baz number ' ~ $_);
        $writer.endElement;
        $writer.endDocument;
        $ok⚛++ if $writer.node.Str eq "<Foo><Baz>This is Baz number {$_}</Baz></Foo>";
        $node;
    }
    is $ok, 20, 'fragments ok';
    lives-ok {
        my $root = $doc.createElement('Doc');
        $root.addChild($_) for @elems;
        $doc.root = $root;
    }
}

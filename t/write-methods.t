use Test;
plan 4;

use LibXML::Writer;
use LibXML::Writer::Buffer;

unless LibXML::Writer.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

sub tail($writer, &m) {
    $writer.writeText: "\n";
    &m($writer);
    $writer.flush;
    $writer.Str.lines.tail;
}

my LibXML::Writer::Buffer:D $writer .= new;
ok $writer.raw.defined;
$writer.startDocument();
$writer.startElement('Test');

subtest 'writeElement', {

    is tail($writer, { .writeElement('Xxx') }), '<Xxx/>';
    is tail($writer, { .writeElement('Xxx', 'Yy>yy') }), '<Xxx>Yy&gt;yy</Xxx>';

}

subtest 'writeElementNS', {
    is tail($writer, { .writeElementNS('Foo') }), '<Foo></Foo>';
    is tail($writer, { .writeElementNS('Foo', 'x&y') }), '<Foo>x&amp;y</Foo>';
    is tail($writer, { .writeElementNS('Foo', :prefix<p>) }), '<p:Foo></p:Foo>';
    is tail($writer, { .writeElementNS('Foo', :uri<https::/example.org>) }), '<Foo xmlns="https::/example.org"></Foo>';
    is tail($writer, { .writeElementNS('Foo', :prefix<p> :uri<https::/example.org>) }), '<p:Foo xmlns:p="https::/example.org"></p:Foo>';

    is tail($writer, { .startElement('Foo'); .writeAttribute("k", "a&b"); .endElement() }), '<Foo k="a&amp;b"/>';
    is tail($writer, { .startElementNS('Foo', :prefix<p>); .writeAttributeNS("k", "a&b", :prefix<q>); .endElement() }), '<p:Foo q:k="a&amp;b"/>';
}

subtest 'text and comments', {

    is tail($writer, { .writeComment('Yy-->yy') }), '<!--Yy--><!--yy-->';

    is tail($writer, { .writeText('A&B') }), 'A&amp;B';
    is tail($writer, { .writeRaw('A&amp;B') }), 'A&amp;B';
    is tail($writer, { .writeCDATA('A&B') }), '<![CDATA[A&B]]>';
    is tail($writer, { .writeCDATA('A&B]]>') }), '<![CDATA[A&B]]]><![CDATA[]>]]>';

    is tail($writer, { .writePI("xxx", 'yyy="zzz"'); }), '<?xxx yyy="zzz"?>';
    $writer.endElement;
    $writer.endDocument;

}

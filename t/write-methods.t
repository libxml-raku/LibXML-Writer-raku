use Test;
plan 7;

use LibXML::Writer;
use LibXML::Writer::Buffer;

unless LibXML::Writer.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

sub tail($writer, &m?) {
    $writer.writeText: "\n";
    .($writer) with &m;
    $writer.flush;
    $writer.Str.lines.tail;
}

my LibXML::Writer::Buffer:D $writer .= new;
ok $writer.raw.defined;
$writer.startDocument( :enc<UTF-8> , :version<1.0>, :standalone);

$writer.flush;
is $writer.Str.chomp, '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';

$writer.startElement('Test');

subtest 'writeElement', {
    is $writer.&tail({ .writeElement('Xxx') }), '<Xxx/>';
    is $writer.&tail({ .writeElement('Xxx', 'Yy>yy') }), '<Xxx>Yy&gt;yy</Xxx>';

}

subtest 'writeAttribute', {
    is $writer.&tail({ .startElement('Foo'); .writeAttribute("A", "a&b"); .endElement() }), '<Foo A="a&amp;b"/>';
    $writer.setQuoteChar("'");
    is $writer.&tail({ .startElement('Foo'); .writeAttribute("B", "bbb"); .writeText("ttt"); .endElement() }), "<Foo B='bbb'>ttt</Foo>";
    $writer.setQuoteChar('"');
    is $writer.&tail({ .startElement('Foo'); .writeAttribute("B", "bbb"); .writeText("ttt"); .endElement() }), '<Foo B="bbb">ttt</Foo>';
}

subtest 'setIndent', {
    is $writer.&tail({ .setIndent; .writeElement('Yyy') }), ' <Yyy/>';
    is $writer.&tail({ .setIndentString("   "); .writeElement('Zzz') }), '   <Zzz/>';
    is $writer.&tail({ .setIndentString("<!--X-->"); .writeElement('Zzz') }), '<!--X--><Zzz/>';
    $writer.setIndent(False);
}

subtest 'writeElementNS', {
    is $writer.&tail({ .writeElementNS('Foo') }), '<Foo></Foo>';
    is $writer.&tail({ .writeElementNS('Foo', 'x&y') }), '<Foo>x&amp;y</Foo>';
    is $writer.&tail({ .writeElementNS('Foo', :prefix<p>) }), '<p:Foo></p:Foo>';
    is $writer.&tail({ .writeElementNS('Foo', :uri<https::/example.org>) }), '<Foo xmlns="https::/example.org"></Foo>';
    is $writer.&tail({ .writeElementNS('Foo', :prefix<p> :uri<https::/example.org>) }), '<p:Foo xmlns:p="https::/example.org"></p:Foo>';

    is $writer.&tail({ .startElementNS('Foo', :prefix<p>); .writeAttributeNS("k", "a&b", :prefix<q>); .endElement() }), '<p:Foo q:k="a&amp;b"/>';
}

subtest 'text and comments', {

    is $writer.&tail({ .writeComment('Yy-->yy') }), '<!--Yy-- >yy-->';

    is $writer.&tail({ .writeText('A&B') }), 'A&amp;B';
    is $writer.&tail({ .writeRaw('A&amp;B') }), 'A&amp;B';
    is $writer.&tail({ .writeCDATA('A&B') }), '<![CDATA[A&B]]>';
    is $writer.&tail({ .writeCDATA('A&B]]>') }), '<![CDATA[A&B]]]><![CDATA[]>]]>';

    is $writer.&tail({ .writePI("xxx", 'yyy="zzz"'); }), '<?xxx yyy="zzz"?>';
    $writer.endElement;
    $writer.endDocument;

}

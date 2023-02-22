use Test;
plan 6;

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
$writer.startDocument( :enc<UTF-8> , :version<1.0>, :stand-alone<yes>);

$writer.flush;
is $writer.Str.chomp, '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';

subtest 'writeDtd', {

    $writer.writeDTD('html', :public-id('-//W3C//DTD HTML 4.0 Transitional//EN'), :system-id<http://www.w3.org/TR/REC-html40/loose.dtd>);

    $writer.startElement('Test');

    is tail($writer), '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd"><Test>';

    my LibXML::Writer::Buffer:D $writer2 .= new;
    $writer2.startDocument;
    is tail($writer2, {.startDTD('html', :public-id('-//W3C//DTD HTML 4.0 Transitional//EN'), :system-id<http://www.w3.org/TR/REC-html40/loose.dtd>)}), '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd"';
    is tail($writer2, {.endDTD}), ']>';
}

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

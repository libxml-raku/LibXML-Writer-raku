use Test;
use LibXML::Writer::Buffer;
plan 1;

unless LibXML::Writer::Buffer.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

subtest 'buffer writer sanity', {
    my LibXML::Writer::Buffer:D $writer .= new;
    ok $writer.raw.defined;
    $writer.startDocument();
    $writer.startElement('Foo');
    $writer.endElement;
    $writer.endDocument;
    $writer.flush;
    is $writer.Str.lines.join, '<?xml version="1.0"?><Foo/>';
}


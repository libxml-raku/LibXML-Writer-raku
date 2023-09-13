use Test;
use LibXML::Document;
use LibXML::Writer::Document;

plan 1;

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


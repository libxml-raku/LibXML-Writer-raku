use Test;
plan 3;

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


my $text = '∮ E⋅da = Q,  n → ∞, ∑ f(i) = ∏ g(i)';
my LibXML::Writer::Buffer $writer;

subtest 'utf-8', {
    $writer .= new;
    $writer.startDocument( :enc<UTF-8> , :version<1.0>, :stand-alone<yes>);
    $writer.startElement('Test');
    is $writer.enc, 'UTF-8';
    is tail($writer, {.writeText($text) }), $text;
    is-deeply $writer.Blob.subbuf(0,6).List, (0x3C, 0x3F, 0x78, 0x6D, 0x6C, 0x20);
}

subtest 'utf-16', {
    $writer .= new;
    $writer.startDocument( :enc<UTF-16> , :version<1.0>, :stand-alone<yes>);
    $writer.startElement('Test');
    is $writer.enc, 'UTF-16';
    is tail($writer, {.writeText($text) }), $text;
    is-deeply $writer.Blob.subbuf(0,6).List, (0xFF, 0xFE, 0x3C, 0x00, 0x3F, 0x00);
}

subtest 'iso-8859-1', {
    $writer .= new;
    $writer.startDocument( :enc<ISO-8859-1> , :version<1.0>, :stand-alone<yes>);
    $writer.startElement('Test');
    is $writer.enc, 'ISO-8859-1';
    is tail($writer, {.writeText($text) }), '&#8750; E&#8901;da = Q,  n &#8594; &#8734;, &#8721; f(i) = &#8719; g(i)';
    is-deeply $writer.Blob.subbuf(0,6).List, (60, 63, 120, 109, 108, 32);
}


$writer .= new;

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

subtest 'writeDTD', {

    my LibXML::Writer::Buffer:D $writer .= new;
    $writer.startDocument;

    $writer.writeDTD('html', :public-id('-//W3C//DTD HTML 4.0 Transitional//EN'), :system-id<http://www.w3.org/TR/REC-html40/loose.dtd>);

    $writer.startElement('Test');

    is $writer.&tail(), '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd"><Test>';
}

subtest 'startDTD + endDTD', {
    my LibXML::Writer::Buffer:D $writer .= new;
    $writer.startDocument;
    is $writer.&tail({.startDTD('html', :public-id('-//W3C//DTD HTML 4.0 Transitional//EN'), :system-id<http://www.w3.org/TR/REC-html40/loose.dtd>)}), '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd"';
    is $writer.&tail({.endDTD}), ']>';
}

subtest 'writeDTDElement', {
    my LibXML::Writer::Buffer:D $writer .= new;
    $writer.startDocument;
    is $writer.&tail({.startDTD('html', :public-id('-//W3C//DTD HTML 4.0 Transitional//EN'), :system-id<http://www.w3.org/TR/REC-html40/loose.dtd>)}), '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd"';
    is $writer.&tail({.writeDTDElement('Xxx')}), '<!ELEMENT Xxx (EMPTY*)>', 'writeDTDElement';
    is $writer.&tail({.writeDTDElement('Yyy', '(Xxx)*')}), '<!ELEMENT Yyy (Xxx)*>', 'writeDTDElement';
    is $writer.&tail({.writeDTDAttlist('Color', 'CDATA')}), '<!ELEMENT Yyy (Xxx)*>', 'writeDTDElement';
    is $writer.&tail({.endDTD}), ']>';
}


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
    is $writer.&tail({.writeDTDAttlist('Color', 'CDATA')}), '<!ATTLIST Color CDATA>', 'writeDTDAttlist';
    is $writer.&tail({.startDTDEntity('Foo')}), '<!ENTITY Foo', 'startDTDEntity';
    is $writer.&tail({.endDTDEntity()}), '">', 'endDTDEntity';
    is $writer.&tail({.writeDTDInternalEntity('Foo', 'Xxx')}), '<!ENTITY Foo "Xxx">', 'writeDTDInternalEntity';
    is $writer.&tail({.writeDTDInternalEntity('Foo', 'Xxx | Yyy', :pe)}), '<!ENTITY % Foo "Xxx | Yyy">', 'writeDTDInternalEntity';
    is $writer.&tail({.writeDTDExternalEntity('html', :public-id('-//W3C//DTD HTML 4.0 Transitional//EN'), :system-id<http://www.w3.org/TR/REC-html40/loose.dtd>)}), q{<!ENTITY html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">};
    is $writer.&tail({.writeDTDExternalEntity('pictures', :system-id<images/plage.gif>, :ndata<gif89a>)}), q{<!ENTITY pictures SYSTEM "images/plage.gif" NDATA gif89a>};
    is $writer.&tail({.writeDTDNotation('gif89a', :public-id('-//CompuServe//NOTATION Graphics Interchange Format 89a//EN'), :system-id<gif>) }), q{<!NOTATION gif89a PUBLIC "-//CompuServe//NOTATION Graphics Interchange Format 89a//EN" "gif">};

    is $writer.&tail({.endDTD}), ']>';
}


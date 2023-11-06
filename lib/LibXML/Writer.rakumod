#| Interface to libxml2 stream writer
unit class LibXML::Writer;

use LibXML::_Configurable;
also does LibXML::_Configurable;

use LibXML::Raw;
use LibXML::Raw::TextWriter;
use LibXML::Types :QName, :NCName;
use LibXML::ErrorHandling;
use LibXML::Item;
use LibXML::Enums;
use Method::Also;
use NativeCall;

has xmlTextWriter $.raw is rw is built;
has Str $.enc = 'UTF-8';

=head2 Methods

#| Ensure libxml2 has been compiled with the text-writer enabled
method have-writer returns Bool {
    ? xml6_config_have_libxml_writer();
}

method !write(Str:D $op, |c) is hidden-from-backtrace {
    my Int $rv := $!raw."$op"(|c);
    fail X::LibXML::OpFail.new(:what<Write>, :$op)
        if $rv < 0;
    $rv;
}

multi sub trait_mod:<is>(
    Method $m where .yada,
    :$writer-raw!) {
    $m.wrap(method (|c) is hidden-from-backtrace { self!write($m.name, |c) })
}

=head3 Indentation

#| Enable or disable indentation
method setIndented(Bool:D() $indented = True) {  self!write('setIndented', $indented); }
#| Set indentation text
method setIndentString(Str:D $indent)  {  self!write('setIndentString', $indent); }
#| Set character for quoting attributes
method setQuoteChar(Str:D $quote) { self!write('setQuoteChar', $quote.ord); }

## traits not working
## method startElement(QName $name) is writer-raw {...}

=head3 Document Methods

#| Starts the document and writes the XML declaration
method startDocument(Str :$version, Str:D :$!enc = 'UTF-8', Bool :$standalone) {
    my Str $standalone-yn = $_ ?? 'yes' !! 'no'
        with $standalone;
    self!write('startDocument', $version, $!enc, $standalone-yn);
}

#| Closes any open elements or attributes and finishes the document
method endDocument { self!write('endDocument')}

=head3 Element Methods

#| Writes the specified start tag
method startElement(QName $name) { self!write('startElement', $name)}

#| Writes the specified start tag and associates it with the given name-space and prefix
method startElementNS(NCName $local-name, Str :$prefix, Str :$uri) { self!write('startElementNS', $prefix, $local-name, $uri)}

#| Closes the current element
method endElement { self!write('endElement')}

#| Writes an XML attribute, within an element
method writeAttribute(QName $name, Str $content) { self!write('writeAttribute', $name, $content)}

#| Writes an XML attribute with an associated name-space and prefix, within an element
method writeAttributeNS(NCName $local-name, Str $content, Str :$prefix, Str :$uri) { self!write('writeAttributeNS', $prefix, $local-name, $uri, $content)}

#| Writes an atomic element; Either empty or with the given content
method writeElement(QName $name, Str $content?) { self!write('writeElement', $name, $content)}

#| Writes an atomic element with an associated name-space and prefix
method writeElementNS(NCName $local-name, Str $content = '', Str :$prefix, Str :$uri) { self!write('writeElementNS', $prefix, $local-name, $uri, $content)}

#| Writes an XML comment
proto method writeComment(Str:D $content) {*}
multi method writeComment(Str:D $content where .contains('<!--')) {
    $.writeComment: $content.split(/'<!--'/).join('< !--');
}
multi method writeComment(Str:D $content where .contains('-->')) {
    $.writeComment: $content.split(/'-->'/).join('-- >');
}
multi method writeComment(Str:D $content) { self!write('writeComment', $content)}

#| Writes text content with escaping and encoding
method writeText(Str:D $content) returns UInt { self!write('writeString', $content)}
=begin code :lang<raku>
$bytes-written = $writer.writeText: 'A&B'; # output: A&amp;B
=end code

#| Writes CDATA formatted text content
proto method writeCDATA(Str:D $content) returns UInt {*}
=begin code :lang<raku>
$bytes-written = $writer.writeCDATA: 'A&B'; # output: <![CDATA[A&B]]>
=end code

multi method writeCDATA(Str:D $content where .contains(']]>')) {
    $content.split(/<?after ']'><?before ']>'>/).map({ $.writeCDATA($_) }).sum;
}
multi method writeCDATA(Str:D $content) { self!write('writeCDATA', $content)}

#| Writes a string, with encoding
multi method writeRaw(Str:D $content) { $.writeRaw: $content.encode($!enc) }

#| Writes a pre-encoded buffer directly
multi method writeRaw(blob8:D $content, UInt $len = $content.bytes) { self!write('writeRawLen', $content, $len)}

#| Writes an XML Processing Instruction
method writePI(QName $name, Str $content) { self!write('writePI', $name, $content)}

=head3 DTD Methods

#| Writes an atomic XML DOCTYPE Definition (DTD)
method writeDTD(NCName $name, Str :$public-id, Str :$system-id, Str :$subset) { self!write('writeDTD', $name, $public-id, $system-id, $subset)}

#| Starts an XML DOCTYPE Definition (DTD)
method startDTD(NCName $name, Str :$public-id, Str :$system-id) { self!write('startDTD', $name, $public-id, $system-id)}
=para The methods below can then be used to add definitions for DTD Elements, Attribute Lists, Entities and Notations, before calling `endDTD`.

#| Ends an XML DOCTYPE Definition (DTD)
method endDTD() { self!write('endDTD')}

#| Starts an Element definition with an XML DTD
method startDTDElement(QName $name) { self!write('startDTDElement', $name)}

#| Ends an XML DTD element definition
method endDTDElement { self!write('endDTDElement')}

#| Writes an Element declaration within an XML DTD
method writeDTDElement(QName $name, Str:D $content = '(EMPTY*)') { self!write('writeDTDElement', $name, $content)}

#| Writes an Attribute List declaration within an XML DTD
method writeDTDAttlist(QName $name, Str $content) { self!write('writeDTDAttlist', $name, $content)}

#| Starts an entity definition within an XML DTD
method startDTDEntity(QName $name, Int :$pe) { self!write('startDTDEntity', $pe, $name)}

#| Ends an XML DTD Entity definition
method endDTDEntity { self!write('endDTDEntity')}

#| Writes an Internal Entity definition within an XML DTD
method writeDTDInternalEntity(QName $name, Str:D $content, Int :$pe) { self!write('writeDTDInternalEntity', $pe, $name, $content)}

#| Writes an external entity definition within an XML DTD
method writeDTDExternalEntity(NCName $name, Str :$public-id, Str :$system-id, Str :$ndata, Int :$pe) { self!write('writeDTDExternalEntity', $pe, $name, $public-id, $system-id, $ndata)}

#| Writes a notation definition within an XML DTD
method writeDTDNotation(NCName $name, Str :$public-id, Str :$system-id) { self!write('writeDTDNotation', $name, $public-id, $system-id)}

#| Writes an AST structure
proto method write($ast) {*}

multi method write(Pair $_) {
    my $name = .key;
    my $value = .value;
    $value .= Str if $value ~~ Numeric:D;

    my UInt $node-type := itemNode::NodeType($name);
    my $config = $.config // LibXML::Config.new;

    when $value ~~ Str:D {
        when $name.starts-with('#') {
            given $node-type {
                when XML_COMMENT_NODE { self.writeComment: $value }
                when XML_CDATA_SECTION_NODE { self.writeCDATA: $value }
                when XML_DOCUMENT_NODE {
                    self.startDocument;
                    self.write: $value;
                    self.endDocument;
                }
                default { die "can't handle '$name' of type $node-type"; }
            }
        }
        when $name.starts-with('?') {
            $name .= substr(1);
            self.writePI($name, $value);
        }
        default {
            $name .= substr(1) if $name.starts-with('@');
            self.writeAttribute($name, $value);
        }
    }
    when $name.starts-with('&') {
        $name ~= ';' unless $name.ends-with(';');
        self.writeRaw( $name );
    }
    default {
       given $node-type {
            when XML_ELEMENT_NODE { self.startElement($name) }
            when XML_DOCUMENT_NODE { self.startDocument }
            default {
                die "can't handle '$name' of type $_"
                    unless $_ == XML_DOCUMENT_FRAG_NODE;
            }
        }

        for $value.List {
            self.write($_) if .defined;
        }

       given $node-type {
            when XML_ELEMENT_NODE { self.endElement }
            when XML_DOCUMENT_NODE { self.endDocument }
        }
    }
}

multi method write(Positional $value) { self.write: $_ for $value.list }

multi method write(Str:D() $value) { self.writeText: $value }

#| Flush an buffered XML
method flush { self!write('flush')}

#| Finish writing XML. Flush output and free the native XML Writer
method close {
    with $!raw {
        .flush;
        .Free;
        $_ = Nil;
    }
}

#| XML::Writer compatibility
proto method serialize(|c --> Str:D) {*}
=para For example:
=begin code :lang<raku>
say LibXML::Writer.serialize: "Test" => [:id<abc123>, 'Hello world!'];
# <Test id="abc123">Hello world!</Test>
=end code

multi method serialize(Pair $ast, *% where .elems == 0) {
    my $writer = (require ::('LibXML::Writer::Buffer')).new;
    $writer.write: $ast;
    $writer.Str;
}

multi method serialize(*%named where .elems == 1) {
    self.serialize: %named.pairs[0];
}

submethod DESTROY {
    self.close;
}


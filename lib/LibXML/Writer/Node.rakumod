#| LibXML document fragment/sub-tree construction
unit class LibXML::Writer::Node;

use LibXML::Writer;
also is LibXML::Writer;

use LibXML::Document;
use LibXML::Node;
use LibXML::Raw;
use LibXML::Raw::TextWriter;

has LibXML::Node     $.node is built;
has LibXML::Document $.doc is built;

submethod TWEAK(LibXML::Node:D :$!node!, LibXML::Document:D :$!doc = $!node.doc) is hidden-from-backtrace {
    my xmlDoc  $doc  = .raw with $!doc;
    my xmlNode $node = .raw with $!node;
    self.raw = xmlTextWriter.new(:$doc, :$node)
        // die X::LibXML::OpFail.new(:what<Write>, :op<NewDoc>);
}

method node handles<Str Blob> { $.flush; $!node }

=begin pod

=head2 Synopsis

=begin code :lang<raku>
use LibXML::Document;
use LibXML::Element;
use LibXML::Writer::Node;
my LibXML::Document $doc .= new;
# concurrent sub-tree construction
my LibXML::Element @twigs = (1.10).hyper.map: {
    my LibXML::Element $node = $doc.createElement('Bar');
    my LibXML::Writer::Node $writer .= new: :$node;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    $writer.node;
}
my $root = $doc.createElement('Foo');
$root.addChild($_) for @twigs;
$doc.root = $root;
say $writer.Str;
say $doc.Str;
# <?xml version="1.0" encoding="UTF-8"?>
# <Foo><Bar><Baz/></Bar>...</Foo>
=end code

=head2 Description

This class is used to write sub-trees; stand-alone or within a
containing document.

=end pod

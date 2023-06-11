unit class LibXML::Writer::Document;

use LibXML::Writer;
also is LibXML::Writer;

use LibXML::Document;
use LibXML::Node;
use LibXML::Raw;
use LibXML::Raw::TextWriter;

has LibXML::Document $.doc is built;
has LibXML::Node     $.node is built;

multi method TWEAK(LibXML::Node:D :$!node!, LibXML::Document:D :$!doc = $!node.doc) is hidden-from-backtrace {
    my xmlDoc  $doc  = .raw with $!doc;
    my xmlNode $node = .raw with $!node;
    self.raw = xmlTextWriter.new(:$doc, :$node)
        // die X::LibXML::OpFail.new(:what<Write>, :op<NewDoc>);
}

multi method TWEAK(LibXML::Document:D :$!doc!) is hidden-from-backtrace {
    my xmlDoc  $doc  = $!doc.raw;
    my xmlNode $node = .raw with $!node;
    self.raw = xmlTextWriter.new(:$doc, :$node)
        // die X::LibXML::OpFail.new(:what<Write>, :op<NewMem>);
}

method doc handles<Str Blob> { $.flush; $!doc }

=begin pod

=head2 Synopsis

=begin code :lang<raku>
use LibXML::Document;
use LibXML::Writer::Document;
my LibXML::Document $doc .= new;
my LibXML::Writer::Document:D $writer .= new: :$doc;
$writer.write: '#xml' => ['elem' => ['text']];
say $writer.doc.Str;
# <?xml version="1.0" encoding="UTF-8"?>
# <elem>text</elem>
=end code

=end pod

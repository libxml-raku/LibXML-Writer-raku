#| LibXML document construction
unit class LibXML::Writer::Document;

use LibXML::Writer;
also is LibXML::Writer;

use LibXML::Document;
use LibXML::Raw;
use LibXML::Raw::TextWriter;

has LibXML::Document $.doc is built;

submethod TWEAK(LibXML::Document:D :$!doc!) is hidden-from-backtrace {
    my xmlDoc  $doc  = $!doc.raw;
    self.raw = xmlTextWriter.new(:$doc)
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

=head2 Description

This output class allows a L<LibXML::Document> object to be constructed via L<LibXML::Writer>.

=end pod

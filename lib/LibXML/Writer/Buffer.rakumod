#| In-memory buffer construction
unit class LibXML::Writer::Buffer;

use LibXML::Writer;
also is LibXML::Writer;

use LibXML::Raw;

has xmlBuffer32 $!buf .= new;

method Blob { $.flush; $!buf.Blob }
method Str  { $.Blob.decode: $.enc }

submethod TWEAK is hidden-from-backtrace {
    self.raw .= new(:$!buf)
        // die X::LibXML::OpFail.new(:what<Write>, :op<NewMem>);
}

# XML::Writer compatibility
proto method serialize(|c --> Str:D) {*}

multi method serialize(::?CLASS:U: |c) { self.new.serialize: |c }

multi method serialize(::?CLASS:D: Pair $ast, *% where .elems == 0) {
    self.write: $ast;
    self.Str;
}

multi method serialize(::?CLASS:D: *%named where .elems == 1) {
    self.serialize: %named.pairs[0];
}

=begin pod

=head2 Synopsis

=begin code :lang<raku>
use LibXML::Writer::Buffer; # String or buffer output
my LibXML::Writer::Buffer:D $writer .= new;

$writer.startElement('Test');
$writer.writeAttribute('id', 'abc123');
$writer.writeText('Hello world!');
$writer.endElement();
say $writer.Str;  # <Test id="abc123">Hello world!</Test>
say $writer.Blob; # Buf[uint8]:0x<3C 54 65 ...>

# XML::Writer compatibility
say LibXML::Writer::Buffer.serialize: 'elem' => ['text'];
# <elem>text</elem>
=end code

=head2 Description

This class writes to an in-memory buffer. The final
XML document can then be rendered using the `Str` or
`Blob` methods.

A class-level `serialize method is also provided for
compatibility with L<XML::Writer|https://github.com/Raku/REA/tree/main/archive/X/XML%3A%3AWriter>.

=end pod

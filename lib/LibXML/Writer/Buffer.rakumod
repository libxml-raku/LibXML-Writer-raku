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
use LibXML::Writer::Buffer;
my LibXML::Writer::Buffer:D $writer .= new;
$writer.write: 'elem' => ['text'];
say $writer.Str;  # <elem>text</elem>
say $writer.Blob; # Buf[uint8]:0x<3C 65 6C ...>
=end code

=head2 Description

This output class writes to an in-memory buffer.

=end pod

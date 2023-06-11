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

=begin pod

=head2 Synopsis

=begin code :lang<raku>
use LibXML::Writer::Buffer;
my LibXML::Writer::Buffer:D $writer .= new;
$writer.write: 'elem' => ['text'];
say $writer.Str;  # <elem>text</elem>
say $writer.Blob; # Buf[uint8]:0x<3C 65 6C ...>
=end code

=end pod

#| Stream to an external file
unit class LibXML::Writer::File;

use LibXML::Writer;
also is LibXML::Writer;

use LibXML::Raw;

has Str:D $.file is required;

submethod TWEAK is hidden-from-backtrace {
    self.raw .= new(:$!file)
        // die X::LibXML::OpFail.new(:what<Write>, :op<NewFile>);
}

=begin pod

=head2 Synopsis

    =begin code :lang<raku>
    use File::Temp;
    my (Str:D $file) = tempfile();
    my LibXML::Writer::File $writer .= new: :$file;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    $writer.close;
    my $io = $file.IO;
    say $io.lines.join;  # <?xml version="1.0" encoding="UTF-8"?><Baz/>;
    =end code

=head2 Description

This output class enables efficient low-memory streaming of an XML
document directly to a file.

=end pod

use Test;
use LibXML::Writer::File;

plan 1;

unless LibXML::Writer::File.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

subtest 'file', {
    use File::Temp;
    my (Str:D $file) = tempfile();
    my LibXML::Writer::File $writer .= new: :$file;

    $writer.startDocument();
    $writer.startElement('Baz');
    $writer.endElement;
    $writer.endDocument;
    $writer.close;
    my $io = $file.IO;
    is $io.lines.join, '<?xml version="1.0"?><Baz/>';
}

use Test;
use LibXML::Writer::PushParser;
use LibXML::Document;

plan 1;

unless LibXML::Writer::PushParser.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

subtest 'push-parser', {
    use  LibXML::SAX::Handler::SAX2;
    class SAXShouter is LibXML::SAX::Handler::SAX2 {
        use LibXML::SAX::Builder :sax-cb;
        method startElement($name, |c) is sax-cb {
            nextwith($name.uc, |c);
        }
        method endElement($name, |c) is sax-cb {
            nextwith($name.uc, |c);
        }
        method characters($chars, |c) is sax-cb {
            nextwith($chars.uc, |c);
        }
    }

    my SAXShouter $sax-handler .= new;
    my LibXML::Writer::PushParser $writer .= new: :$sax-handler;

    $writer.startDocument();
    $writer.startElement('Foo');
    $writer.startElement('Bar');
    $writer.endElement;
    $writer.push('<Baz/>');
    $writer.endElement;
    $writer.endDocument;
    my LibXML::Document:D $doc = $writer.finish-push;
    is $doc.Str.lines.join, '<?xml version="1.0" encoding="UTF-8"?><FOO><BAR/><BAZ/></FOO>';
}

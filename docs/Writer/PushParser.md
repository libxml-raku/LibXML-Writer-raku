[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-Writer-raku/Writer)
 :: [PushParser](https://libxml-raku.github.io/LibXML-Writer-raku/Writer/PushParser)

class LibXML::Writer::PushParser
--------------------------------

LibXML push-parser construction

Synopsis
--------

```raku
use LibXML::Writer::PushParser;
use LibXML::SAX::Handler::SAX2;
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

$writer.startDocument;
$writer.startElement('Foo');
$writer.startElement('Bar');
$writer.endElement;
$writer.push('<Baz/>');
$writer.endElement;
$writer.endDocument;
my $doc = $writer.finish-push;
say $doc.Str; # <?xml version="1.0" encoding="UTF-8"?><FOO><BAR/><BAZ/></FOO>
```

Description
-----------

This class allows document construction via an externally defined [LibXML::PushParser](https://libxml-raku.github.io/LibXML-raku/PushParser) object. It extends this, allowing structural elements to be mixed in with document elements.

A [LibXML::SAX::Handler](https://libxml-raku.github.io/LibXML-raku/SAX/Handler) object can optionally be used to intercept or modify parsing events and parser behaviour.


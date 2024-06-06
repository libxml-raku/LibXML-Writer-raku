#| LibXML push-parser construction
unit class LibXML::Writer::PushParser;

use LibXML::Writer;
also is LibXML::Writer;

use LibXML::Raw;
use LibXML::PushParser;

has LibXML::PushParser $!push-parser;

submethod TWEAK(:$chunk = '', |c) is hidden-from-backtrace {
    $!push-parser .= new: :$chunk, |c;
    my xmlParserCtxt:D $ctxt = $!push-parser.ctxt.raw;
    self.raw .= new(:$ctxt)
        // die X::LibXML::OpFail.new(:what<Write>, :op<NewPushParser>);
}

method push(|c) {
    $.flush;
    $!push-parser.push: |c;
}

method finish-push(|c) {
    $.flush;
    $!push-parser.finish-push: |c;
}

method close {
    with $!push-parser {
        .ctxt.raw = Nil; # avoid double free
        $_ = Nil;
        callsame();
    }
}

=begin pod

=head2 Synopsis

    =begin code :lang<raku>
    use LibXML::Writer::PushParser;

    #| Converts element and attribute names to uppercase
    class SAXShouter {...}
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

    class SAXShouter {
        use LibXML::SAX::Builder :sax-cb;
        use LibXML::SAX::Handler::SAX2;
        also is LibXML::SAX::Handler::SAX2;

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
    =end code

=head2 Description

This class allows document construction via an externally defined L<LibXML::PushParser> object. It extends this, allowing structural elements to be mixed in with document elements.

A L<LibXML::SAX::Handler> object can optionally be used to intercept or modify
parsing events and parser behaviour.

=end pod

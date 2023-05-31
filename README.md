LibXML-Writer-raku
=======

Synopsis
-------
```raku
use LibXML::Writer::Buffer; # String or buffer output
my LibXML::Writer::Buffer:D $writer .= new;

$writer.startDocument( :enc<UTF-8> , :version<1.0>, :standalone);
$writer.startElement('Test');
$writer.writeAttribute('id', 'abc123');
$writer.endElement();
$writer.endDocument();
say $writer.Str;
# <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
# <Test id="abc123"/>
```

Methods

### startDocument


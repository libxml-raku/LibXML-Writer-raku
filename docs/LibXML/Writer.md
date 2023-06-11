[[Raku LibXML Project]](https://libxml-raku.github.io)
 / [[LibXML Module]](https://libxml-raku.github.io/LibXML-raku)
 / [Writer](https://libxml-raku.github.io/LibXML-raku/Writer)

class LibXML::Writer
--------------------

Interface to libxml2 stream writer

use LibXML::Writer::Buffer; # write to a string

### method have-writer

```raku
method have-writer() returns Mu
```

Ensure libxml2 has been compiled with the text-writer enabled


use v6;

use LibXML::Writer;
use Test;
plan 3;
ok LibXML::Writer.serialize('a' => [ :b<c>, '<foo>' ]) !~~ / '<foo>' /,
   'plain text is escaped (<>)';
given LibXML::Writer.serialize('a' => [ :b<c>, '&' ]) {
    ok  $_ ~~ / '&amp;' /,
    'plain text is escaped (&)'
        or diag "XML: $_";
}
ok LibXML::Writer.serialize('a' => [ :b<c>, 'a"b' ]) !~~ / 'a"b' /,
   'plain text is escaped (")';


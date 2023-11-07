use v6;

use LibXML::Writer::Buffer;
use Test;
plan 3;
my  LibXML::Writer::Buffer:U $writer;
ok $writer.serialize('a' => [ :b<c>, '<foo>' ]) !~~ / '<foo>' /,
   'plain text is escaped (<>)';
given $writer.serialize('a' => [ :b<c>, '&' ]) {
    ok  $_ ~~ / '&amp;' /,
    'plain text is escaped (&)'
        or diag "XML: $_";
}
ok $writer.serialize('a' => [ :b<c>, 'a"b' ]) !~~ / 'a"b' /,
   'plain text is escaped (")';


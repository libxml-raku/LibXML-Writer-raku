use Test;
plan 8;

use LibXML::Writer::Buffer;
my LibXML::Writer::Buffer:U $writer;

dies-ok {$writer.serialize() }, 'Cannot serialize nothing';

is $writer.serialize(:x[]), '<x/>', 'Single root element (named)';
is $writer.serialize((:x[])), '<x/>', 'Single root element (positional)';

dies-ok {$writer.serialize((:x[]), :x[]) }, 'Can either pass named or positional';

is $writer.serialize(:x['foo']), '<x>foo</x>',
    'Single root element with text contents';

is $writer.serialize(:x[:a<b>, 'foo']), '<x a="b">foo</x>', 'attribute';

is $writer.serialize(:x[12]), '<x>12</x>', 'numbers also work like text';

# check that very long XML output occasionally contains a newline

my $xml = :longidentifier[
    (1..20).flatmap: { ; "foobarbaz$_" => [ 'abc' x 5 ] }
];

todo "line-wrapping";
ok $writer.serialize($xml).match(rx/\n/, :x(5)),
    'Long XML is occasionally line-wrapped';

# vim: ft=perl6

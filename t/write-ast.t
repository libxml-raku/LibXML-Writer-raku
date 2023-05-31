use Test;
plan 9;

use LibXML::Writer;
use LibXML::Writer::Buffer;

unless LibXML::Writer.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

sub tail($writer, &m?) {
    $writer.writeText: "\n";
    .($writer) with &m;
    $writer.Str.lines.tail;
}

my LibXML::Writer::Buffer:D $writer .= new;
ok $writer.raw.defined;
lives-ok { $writer.write: 'abc' => ['efg'] }
is $writer.Str, '<abc>efg</abc>';

my $ast = "#xml" => [
                     :dromedaries[
                              :species['@id' => 1, :name<Camel>, :humps["1 or 2"], :disposition["Cranky"]],
                              :species[:name<Llama>, :humps["1 (sort of)"], :disposition["Aloof"]],
                              :species[:name<Alpaca>, :humps["(see Llama)"], :disposition["Friendly"]]
                          ]
                 ];


$writer .= new;
lives-ok { $writer.write: $ast; }

is $writer.Str.lines.tail, '<dromedaries><species id="1" name="Camel"><humps>1 or 2</humps><disposition>Cranky</disposition></species><species name="Llama"><humps>1 (sort of)</humps><disposition>Aloof</disposition></species><species name="Alpaca"><humps>(see Llama)</humps><disposition>Friendly</disposition></species></dromedaries>';

my $dromedaries = [
    :xmlns("urn:camels"),
    "xmlns:mam" => "urn:mammals",
    :species["Camelid"],
    "mam:legs" => ["xmlns:a" => "urn:a",
                   "xml:lang" => "en",
                   :yyy<zzz>,
                   "a:xxx" => "foo", "4"]
];

$writer .= new;
lives-ok { $writer.write: $dromedaries; }
is $writer.Str, '<species>Camelid</species><mam:legs xmlns:a="urn:a" xml:lang="en" yyy="zzz" a:xxx="foo">4</mam:legs>';

$writer .= new;
lives-ok { $writer.write: '#comment' => '<!-- test -->'; }
is $writer.Str, '<!--< !-- test -- >-->';


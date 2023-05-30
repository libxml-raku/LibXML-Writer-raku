use Test;
plan 2;

use LibXML::Writer;
use LibXML::Writer::Buffer;

unless LibXML::Writer.have-writer {
    skip-rest "LibXML Writer is not supported in this libxml2 build";
    exit;
}

sub tail($writer, &m?) {
    $writer.writeText: "\n";
    .($writer) with &m;
    $writer.flush;
    $writer.Str.lines.tail;
}

my LibXML::Writer::Buffer:D $writer .= new;
ok $writer.raw.defined;
my $ast = "#xml" => [
                     :dromedaries[
                              :species['@id' => 1, :name<Camel>, :humps["1 or 2"], :disposition["Cranky"]],
                              :species[:name<Llama>, :humps["1 (sort of)"], :disposition["Aloof"]],
                              :species[:name<Alpaca>, :humps["(see Llama)"], :disposition["Friendly"]]
                          ]
                 ];


#lives-ok {
$writer.write: $ast; # }

$writer.flush;
is $writer.Str.lines.tail, '<dromedaries><species id="1" name="Camel"><humps>1 or 2</humps><disposition>Cranky</disposition></species><species name="Llama"><humps>1 (sort of)</humps><disposition>Aloof</disposition></species><species name="Alpaca"><humps>(see Llama)</humps><disposition>Friendly</disposition></species></dromedaries>';

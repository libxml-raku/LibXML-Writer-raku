unit module LibXML::Raw::TextWriter;

use NativeCall;
use LibXML::Raw;
use LibXML::Raw::RelaxNG;
use LibXML::Raw::Schema;
use LibXML::Types :QName;
use LibXML::Raw::Defs :$XML2, :$BIND-XML2, :Opaque, :xmlCharP;

sub xml6_config_have_libxml_writer(--> int32) is native($BIND-XML2) is export {*}

class xmlTextWriter is repr(Opaque) is export {

    our sub NewDoc(Pointer[xmlDoc] is rw, int32 --> xmlTextWriter) is symbol('xmlNewTextWriterDoc') is native($XML2) {*}
    our sub NewTree(xmlDoc, xmlNode, int32 --> xmlTextWriter) is symbol('xmlNewTextWriterTree') is native($XML2) {*}
    our sub NewFile(xmlCharP, int32 --> xmlTextWriter) is symbol('xmlNewTextWriterFilename') is native($XML2) {*}
    our sub NewMem(xmlBuffer32, int32 --> xmlTextWriter) is symbol('xmlNewTextWriterMemory') is native($XML2) {*}
    our sub NewPushParser(xmlParserCtxt, int32 --> xmlTextWriter) is symbol('xmlNewTextWriterPushParser') is native($XML2) {*}

    method Free is symbol('xmlFreeTextWriter') is native($XML2) {*}

    method startDocument(xmlCharP $version, xmlCharP $name, xmlCharP $stand-alone --> int32) is symbol('xmlTextWriterStartDocument') is native($XML2) {*}
    method endDocument(--> int32) is symbol('xmlTextWriterEndDocument') is native($XML2) {*}

    method startElement(xmlCharP $name --> int32) is symbol('xmlTextWriterStartElement') is native($XML2) {*}
    method startElementNS(xmlCharP $prefix, xmlCharP $name, xmlCharP $URI --> int32) is symbol('xmlTextWriterStartElementNS') is native($XML2) {*}
    method endElement(--> int32) is symbol('xmlTextWriterEndElement') is native($XML2) {*}
    method writeElement(xmlCharP $name, xmlCharP $content --> int32) is symbol('xmlTextWriterWriteElement') is native($XML2) {*}
    method writeElementNS(xmlCharP $prefix, xmlCharP $name, xmlCharP $URI, xmlCharP $content --> int32) is symbol('xmlTextWriterWriteElementNS') is native($XML2) {*}

    method writeAttribute(xmlCharP $name, xmlCharP $content --> int32) is symbol('xmlTextWriterWriteAttribute') is native($XML2) {*}
    method writeAttributeNS(xmlCharP $prefix, xmlCharP $name, xmlCharP $URI, xmlCharP $content --> int32) is symbol('xmlTextWriterWriteAttributeNS') is native($XML2) {*}

    method writeComment(xmlCharP $content --> int32) is symbol('xmlTextWriterWriteComment') is native($XML2) {*}

    method writeString(xmlCharP $content --> int32) is symbol('xmlTextWriterWriteString') is native($XML2) {*}
    method writeCDATA(xmlCharP $content --> int32) is symbol('xmlTextWriterWriteCDATA') is native($XML2) {*}
    method writeRaw(xmlCharP $content --> int32) is symbol('xmlTextWriterWriteRaw') is native($XML2) {*}
    method writePI(xmlCharP $name, xmlCharP $content --> int32) is symbol('xmlTextWriterWritePI') is native($XML2) {*}

    method writeDTD(xmlCharP $name, xmlCharP $pubid, xmlCharP $sysid, xmlCharP $subset --> int32) is symbol('xmlTextWriterWriteDTD') is native($XML2) {*}

    method startDTD(xmlCharP $name, xmlCharP $pubid, xmlCharP $sysid --> int32) is symbol('xmlTextWriterStartDTD') is native($XML2) {*}

    method endDTD(--> int32) is symbol('xmlTextWriterEndDTD') is native($XML2) {*}

    method flush returns int32 is symbol('xmlTextWriterFlush') is native($XML2) {*}

    multi method new(xmlDoc:D :$doc!, xmlNode :$node!, Int :$compress = 0) {
        NewTree($doc, $node, $compress);
    }

    multi method new(xmlBuffer32:D :$buf!, Int :$compress = 0) {
        NewMem($buf, $compress);
    }

    multi method new(Str:D :$file!, Int :$compress = 0) {
        NewFile($file, $compress);
    }

    multi method new(xmlParserCtxt:D :$ctxt!, Int :$compress = 0) {
        NewPushParser($ctxt, $compress);
    }

    multi method new(|) { fail }
}

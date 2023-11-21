#!/bin/bash

mkdir -p __output/TCW

for f in TCW/*.xml; do 
  xmllint --noout $f
  xsltproc --param CETEI "'/js/CETEI.js'" --param CSS "'/css/tei.css'" make-CETEIcean.xsl $f > "__output/TCW/$(basename -- "$f" .xml).html"; 
done
#!/bin/bash

for f in main/TCW/*.xml; do 
  xmllint --noout $f
  xsltproc --param CETEI "'/js/CETEI.js'" --param CSS "'/css/tei.css'" make-CETEIcean.xsl $f > "TCW/$(basename -- "$f" .xml).html"; 
done
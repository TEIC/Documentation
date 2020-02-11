#!/bin/bash

for f in TCW/*.xml; do 
  xmllint --noout $f
  xsltproc --param CETEI "'/js/CETEI.js'" --param CSS "'/css/tei.css'" make-CETEIcean.xsl $f > "teic.github.io/TCW/$(basename -- "$f" .xml).html"; 
done
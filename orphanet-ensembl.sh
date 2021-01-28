#!/bin/sh
cat orphanet-ensembl.prefix
cat orphanet.tsv | perl -lane '/.*ORDO\/(\w+).*Ensembl:(\w+).*/ and print "ordo:$1 rdfs:seeAlso ensembl:$2 ."'

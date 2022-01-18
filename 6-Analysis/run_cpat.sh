#!/bin/bash

data=../data
gene_file=$data/gtf/merged_transcript.fa

# source ./cpat/bin/activate

python3 cpat/bin/cpat.py -x ./Human_Hexamer.tsv --antisense -d ./Human_logitModel.RData --top-orf=5 -g $gene_file -o output

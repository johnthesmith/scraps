#!/bin/bash

# Определение путей
tmp="./tmp"
dest="./export"

rm -rf $tmp $dest && \
mkdir -p $tmp $dest  && \

cp index.tex $tmp/ && \

pdflatex -interaction=errorstopmode -output-directory=$tmp/ $tmp/index.tex && \
pdflatex -interaction=errorstopmode -output-directory=$tmp/ $tmp/index.tex && \

mv $tmp/*.pdf $dest/ && \

echo RESULT_COMPLETE || echo RESULT_ERROR

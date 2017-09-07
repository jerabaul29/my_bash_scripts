#!/bin/bash

if [ "$1" == "-h" ]; then
  echo "A bash script to do a full recompile of LateX documents, including refs and diff"
  echo "Use: simply call from the directory containing the LaTex files."
  echo "The document to recompile should be called mainfile.tex"
  echo "The name of the old document version should be previous.tex"
  exit 0
fi

# where called from
dir="$(pwd)/"
echo " "
echo "working from ${dir}"
echo " "

# function to do a full recompile of a document, including references
full_recompile (){
  document_name=$1
  echo " "
  echo "***********************************"
  echo "recompile ${document_name}"
  
  pdflatex ${document_name}
  bibtex ${document_name}
  pdflatex ${document_name}
  pdflatex ${document_name}
  
  echo "***********************************"
}

# recompile document
full_recompile mainfile

# generate new diff file, relative to previous.tex
latexdiff previous.tex mainfile.tex > diff_file.tex
full_recompile diff_file

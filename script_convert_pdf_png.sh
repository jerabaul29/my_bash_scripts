#!/bin/bash


if [ "$1" == "-h" ]; then
  echo "A bash script to convert pdf figures to png."
  echo "Use: simply call from the directory containing the figures."
  exit 0
fi

# where called from
dir="$(pwd)/"
echo " "
echo "working from ${dir}"
echo " "

echo "processing extension: .pdf"
  echo "------------------------"
  
  for a in *.pdf
  do
    as_png=${dir}/${a/%pdf/png}
    echo "input: ${a}"
    echo "output: ${as_png}"
  
    convert -density 150 ${a} -quality 90 ${as_png}
  done
  
  echo "------------------------"
  echo " "

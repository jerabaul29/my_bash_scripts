#!/bin/bash

if [ "$1" == "-h" ]; then
  echo "A bash script to convert to pdf and reduce size of figures"
  echo "Use: simply call from the directory containing the figures"
  exit 0
fi

# where called from
dir="$(pwd)/"
echo " "
echo "working from ${dir}"
echo " "

# create directories for output figures
mkdir ${dir}intermediate
mkdir ${dir}ebook

# list of image formats to process; append if necessary
list_formats="
png
jpg
pdf
eps
JPG
"

# function to trim convert and reduce size of all images of a given format
trim_format_image (){
  echo "processing extension: $1"
  echo "------------------------"
  
  for a in *.$1
  do
    trimmed_file=${dir}intermediate/t_${a}
    trimmed_pdf=${dir}intermediate/t_${a/%$1/pdf}
    trimmed_light_pdf=${dir}ebook/e_${a/%$1/pdf}
  
    echo "file: ${a}"
    echo "      ${trimmed_file}"
    echo "      ${trimmed_pdf}"
    echo "      ${trimmed_light_pdf}"
  
    convert -trim "$a" "${trimmed_file}"
    convert "${trimmed_file}" "${trimmed_pdf}"
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${trimmed_light_pdf}" "${trimmed_pdf}"
  done
  
  echo "------------------------"
  echo " "
}

# function to convert and reduce size of all images of a given format
format_image (){
  echo "processing extension: $1"
  echo "------------------------"
  
  for a in *.$1
  do
    pdf=${dir}intermediate/t_${a/%$1/pdf}
    light_pdf=${dir}ebook/e_${a/%$1/pdf}
  
    echo "file: ${a}"
    echo "      ${pdf}"
    echo "      ${light_pdf}"
  
    convert "${a}" "${pdf}"
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${light_pdf}" "${pdf}"
  done
  
  echo "------------------------"
  echo " "
}

# perform the trimming etc.
for crrt_format in ${list_formats}
do
  trim_format_image ${crrt_format}
  # format_image ${crrt_format}
done


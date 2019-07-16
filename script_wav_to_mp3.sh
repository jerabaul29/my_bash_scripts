#!/bin/bash

# a simple script for:
# - getting .wav files from a CD on location basePathIn
# - converting to .mp3 and dumping on basePathOut
# - using track number and cdName for the name of the dumps

# this supposes that we are converting from a cd;
# all files in are in the format: "Track .wav" . If
# there are files others than
# wavs this will mess up with the script

# a way to avoid messing up in this case would be:
# - work with ls instead of ls | wc
# - check the extension

# a possible way to improve:
# - check that no overwrite
# - automate the stuff around the CD name
# - robustness to the track naming format

basePathIn="/run/user/1000/gvfs/cdda:host=sr0/"
basePathOut="/home/jrlab/Desktop/Current/JeaninesMusic/"

cdName="MammaMia"

nbrFilesP1=$(ls -l "${basePathIn}" | wc -l)

# the output of the wc -l is one off compared with the number of files
let "nbrFiles = ${nbrFilesP1} - 1"

echo "nbr of files: ${nbrFiles}"

for fileNbr in $(seq 1 1 ${nbrFiles})
do
    fileIn="Track ${fileNbr}.wav"
    fileOut="CD${cdName}Track${fileNbr}.mp3"

    echo "*********************************"
    echo "ffmpeg of ${fileIn} to ${fileOut}"
    echo "i.e. processing ${fileNbr} / ${nbrFiles}"
    echo "*********************************"

    ffmpeg -i "${basePathIn}${fileIn}" "${basePathOut}${fileOut}"

done

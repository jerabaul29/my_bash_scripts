#!/bin/bash

# TODO: no need to type the last histg pattern
# use: grep histg, and tail, and grep a given field with awk '{print $2}'

if [ "$1" == "-h" ]; then
  echo "A bash script to execute the n-th command shown by histg"
  echo "use: histx number"
  echo "ex : histx 4"
  exit 0
fi

# TODO: automate how to set the PATH_TO_SAVELAST and share it with histx
PATH_TO_SAVELAST="/home/jrlab/Desktop/Git/MyBashScripts/Data/last_histg_output"

SELECTED_COMMAND="$(head -$1 ${PATH_TO_SAVELAST} | tail -1 | cut -c 14-)"
echo "SELECTED_COMMAND ${SELECTED_COMMAND}"
eval ${SELECTED_COMMAND}

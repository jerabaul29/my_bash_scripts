#!/bin/bash

# TODO: no need to type the last histg pattern
# use: grep histg, and tail, and grep a given field with awk '{print $2}'

if [ $# -eq 0 ]; then
    echo "No arguments provided; -h for help"
    exit 1
fi

if [ "$1" == "-h" ]; then
  echo "A bash script to execute the n-th command shown by histg"
  echo "use: histx number"
  echo "ex : histx 4"
  exit 0
fi

OUTPUT=$(~/Desktop/Git/MyBashScripts/histg.sh $1)
STRINGTEST=`echo "${OUTPUT}" | head -$2 | tail -1 | cut -c 14-`
echo "issuing ${STRINGTEST}"
eval ${STRINGTEST}

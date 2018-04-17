#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments provided; -h for help"
    exit 1
fi

if [ "$1" == "-h" ]; then
  echo "A bash script to open manual pages with vim"
  echo "use: vn [function]"
  echo "ex : vn sort"
  exit 0
fi

man $1 | vim -R -
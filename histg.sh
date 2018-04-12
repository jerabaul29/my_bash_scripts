#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments provided; -h for help"
    exit 1
fi

if [ "$1" == "-h" ]; then
  echo "A bash script to find patterns in history, avoiding duplicates (also non consecutive)"
  echo "use: histg [grep patter]"
  echo "ex : histg S.I"
  exit 0
fi

HISTSIZE=100000            # need this, because does not read .bashrc so does not know how big a HISTSIZE
HISTFILE=~/.bash_history   # Or wherever you bash history file lives
set -o history             # enable history

OUTPUT="$(history | grep --color=always $1 | sort -k2 | uniq -f 1 | sort -n | awk '{printf("% 4d  %s\n", NR, $0)}' )"
echo "${OUTPUT}"

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

# TODO: automate how to recover HISTSIZE and share it with bash_rc
HISTSIZE=100000            # need this, because does not read .bashrc so does not know how big a HISTSIZE
HISTFILE=~/.bash_history   # Or wherever you bash history file lives
set -o history             # enable history

# TODO: automate how to set the PATH_TO_SAVELAST and share it with histx
PATH_TO_SAVELAST="/home/jrlab/Desktop/Git/MyBashScripts/Data/last_histg_output"

echo "issuing: ${COMMAND}"
OUTPUT="$(history | grep "$1" | sort -k2 | uniq -f 1 | sort -n | awk '{printf("% 4d  %s\n", NR, $0)}')"
echo "$(echo "${OUTPUT}" | grep --color=always "$1")"

> ${PATH_TO_SAVELAST}
echo "${OUTPUT}" | cat >> ${PATH_TO_SAVELAST}

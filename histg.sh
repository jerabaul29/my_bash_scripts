#!/bin/bash

if [ "$1" == "-h" ]; then
  echo "A bash script to find patterns in history, avoiding duplicates (also non consecutive)"
  echo "expands to: XX"
  exit 0
fi

HISTSIZE=100000            # need this, because does not read .bashrc so does not know how big a HISTSIZE
HISTFILE=~/.bash_history   # Or wherever you bash history file lives
set -o history             # enable history

OUTPUT="$(history | grep --color=always $1 | sort -k2 | uniq -f 1 | sort -n)"
echo "${OUTPUT}"

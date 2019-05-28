#!/bin/bash

# create our tmux
tmux new -s $1 -d

# split and split to get 4 windows
tmux split-window -h
tmux split-window -v
tmux split-window -t 1 -v

# now the splitting is:
###########
#    #    #
# 1  # 2  #
#    #    #
###########
#    #    #
# 4  # 3  #
#    #    #
###########

# # send command to each pane
# tmux send-keys -t 1 "echo 1"  C-m  # the C-m is equivalent to pressing [ENTER]
# tmux send-keys -t 2 "echo 2"  C-m
# tmux send-keys -t 3 "echo 3"  C-m
# tmux send-keys -t 4 "echo 4"  C-m


#!/bin/bash

# A little script to:
# 	- wait that internet is available
# 	- wait for the automatic software update to be finished running
# 	- apply the apt-get update and upgrade to the system
# This means that updates are installed automatically without
# asking confirmation. This should be ok for most vanilla uses.
#
# SETUP
#
# set the XX_SET_PATH to the log file
#
# To make it run automatically, put it in crontab:
# sudo crontab -e
# and in the root crontab that gets opened:
# @reboot bash PATH_TO_THE_SCRIPT.sh

function check_online
{
    netcat -z -w 5 8.8.8.8 53 && return 1 || return 0
}

function wait_online
{
	echo "wait to be online"
	declare -i IS_ONLINE=0
	
	while [ $IS_ONLINE -eq 0 ]; do
	    # We're offline. Sleep for a bit, then check again
	    sleep 2;
	    check_online
	    IS_ONLINE=$?
	done

	echo "now online"
}

{
	echo " "
	echo "new reboot"
	date
	whoami
	wait_online
	echo "wait for 20 minutes to make sure no conflicting catch of dpkg lock"
	sleep 1200
	echo "now start update upgrade..."
	apt-get update
	apt-get upgrade
	apt-get autoremove
} >> XX_SET_PATH 2>&1


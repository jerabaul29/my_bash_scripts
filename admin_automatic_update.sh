#!/bin/bash

##############################################
# A little script to:
# 	- wait that internet is available
# 	- wait for the automatic software update to be finished running
# 	- apply the apt-get update and upgrade to the system
# This means that updates are installed automatically without
# asking confirmation. This should be ok for most vanilla uses.

##############################################
# SETUP
#
# set the path to the log file at the destination of the
# pipe if you do not want to use the "default" location
#
# To make it run automatically, put it in crontab:
# sudo crontab -e
# and in the root crontab that gets opened:
# @reboot bash PATH_TO_THE_SCRIPT.sh

##############################################
# sounder programming environment            
# exit if a command fails
set -o errexit
# make sure to show the error code of the first failing command
set -o pipefail
# do not overwrite files too easily
set -o noclobber
# exit if try to use undefined variable
set -o nounset

##############################################
# source

# check if we are online, by tring to ping google at 8.8.8.8
# print 1 if we are online, 0 if we are not online
# return error code 0 if no bug
function check_online
{
    netcat -z -w 5 8.8.8.8 53 && echo "1" || echo "0"
    return 0
}

# wait until we are online by calling repeatedly the check_online function
# add a small initial delay to let the system be ready to boot etc
function wait_online
{
        echo "wait a bit to let the system start"
        sleep 120
	echo "wait to be online"
	declare -i IS_ONLINE=0
	
	while [ $IS_ONLINE -eq 0 ]; do
	    # We're offline. Sleep for a bit, then check again
	    sleep 2;
	    IS_ONLINE=$(check_online)
	done

	echo "now online"
}

# the core of the script:
# - wait until internet connection is available
# - after that, wait for 20 minutes to make sure automatic updates etc are not ongoing
# - perform a full update, upgrade -y, and autoremove
# - make sure to log the full output to the set path
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
	apt-get upgrade -y
	apt-get autoremove -y
} >> /var/log/script_update_upgrade_autoremove 2>&1


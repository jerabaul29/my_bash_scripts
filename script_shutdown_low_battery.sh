#!/bin/bash

##############################################
# A little script to check if the laptop should be switched off to save the battery
#   - checks if the battery is discharging
#   - if the battery is less than a threshold, shutdown

##############################################
# SETUP
#
# set the path to the log file at the destination of the
# pipe if you do not want to use the "default" location
#
# To make it run automatically, put it in crontab:
# sudo crontab -e
# and in the root crontab that gets opened:
# */5 * * * * sleep 120; bash PATH_TO_THE_SCRIPT.sh
# the sleep is quite important; this way, you will not be taken in
# reboot cycle if there is a mistake in the script or similar...
#
# Also feel free to adjust the thresholds for the shutdown

##############################################
# NOTES
#
# There are several ways to get information about the battery status and level. Looks like which one works best may depend on the system used.
# 
# upower method:
# - to enumerate the sources of information:
# $ upower -e
# - to get information about a device
# $ upower -i /org/freedesktop/UPower/devices/battery_BAT0
# 
# acpi method:
# installed with:
# sudo apt install acpi
# apt-get install acpitool
# ... does not give much on my system
# 
# looking at the syst data, which are present as files in:
# /sys/class/power_supply/BAT0
# does not give the status (cable or not)
# 
# So, on MY specific system, I end up using a upower based method for getting the status of the battery, and the sys info for the percentage

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

# a function to get the battery status
# should be either charging or discharging
# return error code 0 if no bug
function get_status
{
    STATUS="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E state: | xargs | cut -d' ' -f2 | sed s/%//)"
    echo "$STATUS"
    return 0
}

# a function to get the battery level
# should be a number between 0% and 100%
# return error code 0 if no bug
function get_level
{
    LEVEL="$(cat /sys/class/power_supply/BAT0/capacity)"
    echo "$LEVEL"
    return 0
}

# the core part of the script:
# if the battery is discharging, and the level is too low, shutdown
# to be able to shutdown, this should be performed as root
# log this to a file, keeping only the last output (i.e., erase on write)
{
    date
    CRRT_STATUS="$(get_status)"
    
    case "$CRRT_STATUS" in
        "discharging")
            echo "discharging"

            CRRT_LEVEL="$(get_level)"
            if [[ "$CRRT_LEVEL" -lt 50 ]]
            then
                echo "need to shutdown, low battery"
                sudo shutdown now
            fi
            ;;

        "charging")
            echo "charging"
            ;;

        *)
            echo -n "Unknown status: "
            echo "${CRRT_STATUS}"
            ;;
    esac
} >| /var/log/script_shutdown_low_battery 2>&1
# NOTE: to perform some dry run and test, may need to use another location if not working as root
# } >| /home/jr/Desktop/Current/test_script_shutdown_battery/script_shutdown_low_battery 2>&1

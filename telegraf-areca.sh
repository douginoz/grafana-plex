#!/bin/sh
#
# by u/Spincharm
#
# Update telegraf.conf with current dev path mapping for Areca controller
#
# smartctl can poll underlying hard drives within an Areca RAID controller 
# the areca controller path changes randomly on boot, so this script
# needs to run once at boot to identify the current path
#
# It then updates the telegraf configuration with the current path so that
# telegraf monitors it correctly.
#
# Note that grafana panels may need to be updated with the current path 
# (but should be OK since they look for any occurrances of /dev/sg)
#
#
# Find the Areca 'RAID' controller amongst all scsi devices (hopefully the only one!)
#
ARECA=$(/usr/bin/lsscsi -g |/usr/bin/grep 'RAID' |/usr/bin/sed 's|^.*/dev/\(sg[0-9]\)|/dev/\1|')
#
# Change any current value in telegraf.conf to be a generic one
#
sed -i 's+/dev/sg1+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
sed -i 's+/dev/sg2+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
sed -i 's+/dev/sg3+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
sed -i 's+/dev/sg4+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
sed -i 's+/dev/sg5+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
sed -i 's+/dev/sg6+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
sed -i 's+/dev/sg7+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
sed -i 's+/dev/sg8+/dev/sgblah+g' /etc/telegraf/telegraf.d/inputs.smart.conf
#
# Change the generic value to the current correct value
#
sed -i "s+/dev/sgblah +$ARECA+g" /etc/telegraf/telegraf.d/inputs.smart.conf

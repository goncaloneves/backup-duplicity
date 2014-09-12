#!/bin/sh

# Check if user is root
if [ "$(id -u)" -ne "0" ] ; then
	echo "This script must be executed with root privileges."
    exit 1
fi

# Rmove all files
rm /etc/cron.daily/backup
rm /root/.backup-config
rm /root/backup-collect.sh
rm /root/backup-list.sh
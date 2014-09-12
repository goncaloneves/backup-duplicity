#!/bin/bash

# Check if user is root
if [ "$(id -u)" -ne "0" ] ; then
	echo "This script must be executed with root privileges."
    exit 1
fi

# Variables prompts
read -p "What is your remote server ip or domain? " remote
read -p "What is your remote backup directory? (enter for default: /root/backups/ ) " remote_backup_directory
remote_backup_directory=${remote_backup_directory:-/root/backups/}
read -p "Which local directories do you want to backup? (enter for default: \"root\" \"srv\" \"etc\" ) " directories
directories=${directories:-\"root\" \"srv\" \"etc\"}
read -p "What gpg public key will you use to encrypt? (ex: 05AB3DF5) " key
read -p "What is the gpg passphrase to encrypt and decrypt? " passphrase

# Backup configuration export
echo "#!/bin/bash\nexport REMOTE=\"$remote\"\nexport REMOTE_BACKUP_DIRECTORY=\"$remote_backup_directory\"\nexport DIRECTORIES=($directories)\nexport KEY=\"$key\"\nexport PASSPHRASE=\"$passphrase\"" > /root/.backup-config

# Copy daily cron backup file
cp src/backup /etc/cron.daily/
chmod 755 /etc/cron.daily/backup

# Copy backup collect and list
cp src/backup-collect.sh /root/
cp src/backup-list.sh /root/
chmod 755 /root/backup-collect.sh
chmod 755 /root/backup-list.sh

# Installation complete
echo "Installation is complete."
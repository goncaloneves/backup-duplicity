Duplicity Backup Daily Cron
================

Introduction
-------
Use this shell script on Ubuntu systems to easily setup a daily remote backup using Duplicity and GPG encryption.

Usage
-----
After installation, everyday at 6:25am, Duplicity will encrypt and transfer via SFTP your backup folders and send them to your backup server.
Every once in a week it will create a new full backup and in between incremental backups.
You can run these helpful commands to keep up with your backups.

Manually create a new backup:

    bash /etc/cron.daily/backup

Consult your backups stored in your backup server:

    bash /root/backup-collect.sh

Consult all your versioned folders and files in your backup server:

    bash /root/backup-list.sh

Installation
------------
First you need to **install Duplicity** and others tools that it needs on the server we want to backup:

    sudo apt-get install duplicity ncftp python-paramiko

Now let's **create a pair of ssh keys** and transfer them to authenticate with the backup server that will store our backups:
 
    ssh-keygen -t rsa
    ssh-copy-id root@backup-server
 
We are ready to ssh authenticate with our backup server and **create our backups folder**, we will create inside root folder:

    ssh root@backup-server
    mkdir -p /root/backups
    exit

Time to **create our GPG encryption/decryption key to use in all our backups**. Keys will be stored in `/root/.gnupg/`. During creation it will prompt different settings, just press enter for default settings and fill your user details:

    gpg --gen-key

When it comes to `Enter passphrase:` memorize it and don't forget it because you will later need for encryption/decryption.

After generating entropy it will show information about your key. Write down your public key, in this example `B2FC3GE2`:

    pub   2048R/B2FC3GE2 2014-09-12

Now we are **ready to install Duplicity Backup Daily Cron**. We will get the zip file from Github and place inside `/root/` folder:

    cd /root/
    wget -O backup-duplicity.zip https://github.com/goncaloneves/backup-duplicity/zipball/master

To **unzip it**, you need to have installed zip, skip the first command if you do:

    sudo apt-get install zip
    unzip backup-duplicity
    
Let's cd in our uncompressed folder and check its content:

    cd goncalo*
    ls
    
You should have:

    LICENSE  README.md  backup-install.sh  backup-uninstall.sh  src

To **install** run the next command and fill the prompts with the information you have from  the previous steps:

    bash backup-install.sh

This script creates inside `/root/`:

 - .backup-config: installation prompts output, you can update later.
 - backup-collect.sh: consult your backups collection information.
 - backup-list.sh: consult your backups folders and files.

and in `/etc/cron.daily`:

 - backup: this is your daily cron file that executes your backup, you can modify this if you need to change something about your backup command. By default Ubuntu runs all cron.daily executables at 6:25am. You can change timers with `nano /etc/crontab`.

To **uninstall** run:
  
    bash backup-uninstall.sh

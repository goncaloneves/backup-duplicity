. ./.backup-config

duplicity list-current-files sftp://root@${REMOTE}/${REMOTE_BACKUP_DIRECTORY}

unset DIRECTORIES
unset DIRECTORIES_INCLUDE
unset KEY
unset PASSPHRASE
unset REMOTE
unset REMOTE_BACKUP_DIRECTORY
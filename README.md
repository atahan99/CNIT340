# CNIT340

dosutil.sh file description: 
- The script will take DOS/Windows commands as the first parameter and perform the equivalent UNIX command
 
 backup and restore files description:
- The backup script will recursively backup a directory based on the content of a configuration file o The format for the configuration file is provided in the attached file (please save it as /etc/backup.conf).
- The backup script will be executed from the command line in the form: backup name o Where name corresponds to an entry in /etc/backup.conf
- The backup script can operate manually or automatically (by adding an entry in crontab)
- The restore script will prompt the user for the filesystem to restore and a restore target o The user must verify directory/file overwrites
- To backup and restore privileged files the scripts must be able to run as root

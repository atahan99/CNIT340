#!/bin/bash
#Atahan Kucuk
#Purpose of this script is to create a backup using a configuration file
#Revision date: 12.05.2020
#Usage: ./backup.sh <directory>(config or home)

#Declaration of variables

if [[ -z $1 ]]
then echo " please enter what you want to backup (home or config)"
read INPUT
exit 1;
fi

COMMANDS="$(grep "^[^#;]" /etc/backup.conf)"

COMPRESSION="${COMMANDS:12:4}"
BACKUP_TARGET=${COMMANDS:56:7}

INPUT=$1
BACKUP_SOURCE=
BACKUP_NAME=
#Determine the backup source
if [[ $INPUT = "home" ]]
then BACKUP_SOURCE=/home
BACKUP_NAME=home
elif [[ $INPUT = "config" ]]
then BACKUP_SOURCE=/etc
BACKUP_NAME=config
fi

EMAIL="$(grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" /etc/backup.conf )"
DATE=$(date +%-Y-%-m-%-d)
TIME=$(date +%-H:%-M:%S)
HOSTNAME=$(hostname -s)


#Run as root
[ "$EUID" -eq 0 ]|| {
	echo 'Please run as root or with sudo'
	exit 1
}

#check if the target destination exist and if not create a new directory
[ -d "$BACKUP_TARGET" ]||{
mkdir $BACKUP_TARGET
chomod 777 $BACKUP_TARGET
}

#Print the starting variables
echo Starting Variables
echo COMPRESSION = $COMPRESSION
echo BACKUP_TARGET = $BACKUP_TARGET
echo BACKUP_SOURCE = $BACKUP_SOURCE
echo EMAIL = $EMAIL
echo DATE = $DATE
echo TIME = $TIME
echo HOSTNAME = $HOSTNAME
echo "Backing up $BACKUP_SOURCE to $BACKUP_TARGET"

#get a list of files
FILES=( $(ls $BACKUP_SOURCE) )
ARCHIVE=$HOSTNAME.$BACKUP_NAME.$DATE.$TIME

#backup
#create the backup file with tar  and gzip
if [[ $COMPRESSION = "gzip" ]] 
then tar -cPzf $BACKUP_TARGET/$ARCHIVE.tar.gz $BACKUP_SOURCE
fi

#creating log files
LOG=/var/log/backup
LOGNAME=$BACKUPNAME.$DATE.$TIME

function log(){
touch $LOG/$LOGNAME
echo $FILES > $LOG/$LOGNAME

}

if [ -d "$LOG" ];then
log

else 
mkdir $LOG
chmod 777 $LOG
log

fi

#completion
echo Backup completed
echo "You can find the backup files in $BACKUP_TARGET directory"
echo "You can find the log files in $LOG directory"







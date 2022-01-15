#!/bin/bash
# Atahan Kucuk
# Purpose of this script is to convert DOS commands into UNIX commands
# Revision date : 11.20.2020
# 1, 2, 3 represents different arguments that the user will enter and this script will process

PS3="Please make a selection: "; export PS3

options=(type copy ren del move help copy! move! ren!)
INPUT=$1
FILE1=$2
FILE2=$3
FILE_DIR_CHECK=$FILE1/$FILE2
MENU=
SFILE1=
files=( $(ls .) )
twofiles=( "copy" "ren" "move" "copy!" "move!" "ren!" )
START=0
# Function to execute commands
function comm_exec()
{

#DOS commands to UNIX commands conversion cases
case $INPUT in
author)
	echo 'Kucuk, Atahan'
;;
# type command on DOS
type ) 

	if [[ -z $2 ]]
	then echo please enter the file name you would like to see
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran :  cat $FILE1"
	echo content of the file:
	cat $FILE1
       	fi	
	
;;
# copy command on DOS
copy )
	if [[ -z $2 ]]
	then echo please enter the file name  you would like to copy;
	echo plese enter the new file name
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran: cp -n $FILE1 $FILE2"
	cp -n $FILE1 $FILE2 > /dev/null 2>&1
      	echo File Copied	
	fi


;;
# rename or ren command on DOS
ren )
	if [[ -z $2 ]] 
	then echo please enter the file name you would like to move;
	echo please enter the new file name
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran : mv $FILE1 $FILE2 "
	mv $FILE1 $FILE2 > /dev/null 2>&1
	echo file renamed
	fi
;; 
#Move command on DOS
move )
	if [[ -z $2 ]] 
	then echo please enter the file name you would like to move;	
	echo please enter the new filename	
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran : $FILE1 $FILE2"
	mv $FILE1 $FILE2 > /dev/null 2>&1
	echo file moved
	fi 


;;
# delete or del command on DOS
del)
	if [[ -z $2 ]] 
	then echo please enter the file name you would like to delete;
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran: $FILE1 $FILE2"
	rm  $FILE1 > /dev/null 2>&1
	echo file is deleted
	fi


;;
# help command on DOS
help)
	echo supported commands: 
	echo -author : display the name of the user '--> ./dosutil.kucuk.sh author'
	echo -type : look inside of a file '--> ./dosutil.kucuk.sh type filename'
	echo -copy : copy a file '--> ./dosutil.kucuk.sh copy filename1/filepath1 filename2/filepath2'
	echo -ren : rename a file '--> ./dosutil.kucuk.sh ren filename1/filepath1 filename2/filepath2'
	echo -move : move a file '--> ./dosutil.kucuk.sh move filename1/filepath1 filename2/filepath2'
	echo -del : remove the specified file '--> ./dosutil.kucuk.sh del filename'
	echo -help	: list supported commands '--> ./dosutil.kucuk.sh help'
	echo -copy! : copy a file with overwrite '--> ./dosutil.kucuk.sh copy! file1 file2' 
	echo -move! : move a file with overwrite '--> ./dosutil.kucuk.sh move! file1 file2'
	echo -ren! : rename a file with overwrite '--> ./dosutil.kucuk.sh ren! file1 file2'
	echo if running this script from another directory other than '/usr/local/bin' add the file path before './dosutil'


;;
# For an invalid command (commands not mentioned above)
*) 
	echo Command Not Found!!
	/usr/local/bin/./dosutil.kucuk.sh help
;;

# copy command to overwrite existing files/ directories
copy!)
	
	if [[ -z $2 ]]
	then echo please enter the file you would like to copy;
	echo please enter the new file name
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran: yes | cp $FILE1 $FILE2"
	yes | cp $FILE1 $FILE2 > /dev/null 2>&1
	echo file copied	
	fi
;;
# move command to overwrite existing files 
move!)

	if [[ -z $2 ]]
	then echo please enter the file name you would like to move;
	echo please enter the file name
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran : mv -f $FILE1 $FILE2"
	mv -f $FILE1 $FILE2 > /dev/null 2>&1
	echo file moved
	fi
	

;;

# rename command to overwrite existing files
ren!)

	if [[ -z $2 ]]
	then echo please enter the file name you would like to move;
	echo please enter the new file name
	check_file $FILE_DIR_CHECK
	echo "UNIX command ran: mv -f $FILE1 $FILE2"
	mv -f $FILE1 $FILE2 > /dev/null 2>&1
	echo file renamed
	fi

;;
esac

}


# Function to verify files
function check_file()
{


for FILE_DIR_CHECK in $FILE1 $FILE2
do 

	if [ -e "$FILE_DIR_CHECK" ]; then
		echo "$FILE_DIR_CHECK exists"
		if [ -f "$FILE_DIR_CHECK" ]; then
		echo "$FILE_DIR_CHECK is a normal file"
		fi
		if [ -d "$FILE_DIR_CHECK" ]; then
		echo "$FILE_DIR_CHECK is a directory"
		fi
	else
		echo "$FILE_DIR_CHECK does not exist"
		




fi
done
	



			

}


#start conditions of the script
if [[ -z $1 ]]
# MENU list the available methods for this script to run 
then select MENU in "${options[@]}";
do
	echo -e "you picked $MENU ($REPLY)"
	INPUT=$MENU
	START=1
	break
done
#Select menu for the files in the directory where this script ran
echo select a file for FILE1 for source file
select SFILE1 in "${files[@]}";
do
	echo -e "you picked $SFILE1 ($REPLY)"
	FILE1=$SFILE1
break
done	
#IF there is a method that require a destination file it will prompt the user for that info
for  SFILE2 in "${twofiles[@]}";
do
SFILE2=$INPUT
if [[ "${SFILE2}" == "${twofiles}" ]];
then echo enter a name for destination file
read FILE2
break
fi
done
#running the main part of the script 
comm_exec $INPUT
#reading user input to run the script as a command without the need of the menu 
if [ $START == 0 ] ; then 
read INPUT
read FILE1
read FILE2
fi
exit 1;
fi
comm_exec $INPUT



























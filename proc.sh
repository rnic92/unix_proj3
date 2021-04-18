#!/bin/bash

# Nicolas Rohr
# version 1.0
# Apr 18 2021
# Process portion of project 3
invar=0
print_continue() {
	while [ true ]; do
	read -n1 -s -r -p $'Press [Enter] to continue...\n' key
	if [ "$key" == '' ]; then
		break;
	fi
done
}
while [ $invar != 4 ]
do
echo "(Please enter the number of your selection below)"
echo "1. Show all processes"
echo "2. Kill a process"
echo "3. Bring up top"
echo "4. Return to Main Menu"

read invar
case $invar in
	1) # show all
		ps o uid,pid,ppid,c,stime,tty,time,cmd
		print_continue
		;;
	2) #kill
		read -p "Please enter the PID of the process you would like to kill : " proctokill
		kill $proctokill
		;;
	3) #top
		top
		;;
	4) #return wlil exit when while loop is satisfied
		;;
	*) #nothing
		;;

esac
done
exit

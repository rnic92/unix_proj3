#!/bin/bash

selection=$1;

print_continue() { # wait for enter
	while [ true ]; do
	read -n1 -s -r -p $'Press [Enter] to continue...\n' key
	if [ "$key" == '' ]; then
		exit;
	fi
done
}
divider() { # divider makes ---------------- along entire width
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

case $selection in
	1) # system info
		divider
		echo "System Information"
		divider

		/usr/bin/lsb_release -a
		print_continue
		;;
	2) # hostname
		divider
		echo "Hostname and DNS information"
		divider
		echo "Hostname :$(hostname)"
	        echo "DNS domain : $(hostname -d)"
		echo "Fully qualified domain name : $(hostname -f)"
		echo "Network address (IP) : $(hostname -i)"
		echo "DNS name servers (DNS IP) : $(hostname -d)"	
		print_continue
		;;
	3) # Network info
		divider
		echo "Network Information"
		divider
		echo "Total network interfaces found : $(ip -o link show | wc -l)"
		echo "*** IP Adresses Information ***"
		ip -o link show
		echo "***********************"
		echo "*** Network routing ***"
		echo "***********************"
		netstat -rn
		echo "**************************************"
		echo "*** Interface traffic Information ***"
		echo "**************************************"
		netstat -i
		print_continue
		;;
	4) # Who is online current
		divider
		echo "Who is online"
		divider
		who -H
		print_continue
		;;
	5)# list of last logged in users
		divider
		echo "List of last logged in users"
		divider
		last
		print_continue
		;;
	6) # My ip address
		divider
		echo " Public IP Information"
		divider
		wget -qO - icanhazip.com
		print_continue
		;;
	7) # my disk usage
		divider
		echo " Disk Usage Info"
		divider
		df --output=pcent,target
		print_continue
		;;
	8)
		divider
		echo " TODO file tree"
		divider
		;;
	9)
		./proc.sh
		;;
	*)
		;;
esac
exit


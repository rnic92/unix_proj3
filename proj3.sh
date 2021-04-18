#!/bin/bash

# Nicolas Rohr
# version 1.0
# Apr 18 2021

# Main menu portion of program
# prints options in a while loop that exits on 10

print_menu() {
date -u
nl="
"
divider="----------------"
echo $divider
echo " Main Menu "
echo $divider
echo "1. Operating system info"
echo "2. Hostname and DNS info"
echo "3. Network info"
echo "4. Who is online"
echo "5. Last logged in users"
echo "6. My IP address"
echo "7. My disk usage"
echo "8. My home file-tree"
echo "9. Process operations"
echo "10. Exit"
read -p "Enter your choice [1 - 10] " invar
}
invar=0 # initalize to non-real selection
while [ $invar != 10 ]
do
	print_menu
	./selection.sh $invar # call selection.sh with selected value

done
exit

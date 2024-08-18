#! /bin/bash
users=$( awk -F: '$3 >= 1000 {print NR, $1}' /etc/passwd )
whiptail --msgbox "Users on the system:\n$users" 0 0
exec ./main_menu.sh 


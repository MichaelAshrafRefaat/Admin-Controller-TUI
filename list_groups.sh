#!/bin/bash
# awk -F: '$3 >= 1000 {print $1}' /etc/group
groups=$(awk -F: '$3 >= 1000 {print NR, $1}' /etc/group)
        whiptail --msgbox "Groups on the system:\n$groups" 0 0
exec ./main_menu.sh

#!/bin/bash

USERNAME=$(whiptail --inputbox "Enter username:" 8 39 --title "Add User" 3>&2 2>&1 1>&3)
sudo adduser $USERNAME
if [ $? -eq 0 ]; then
    whiptail --msgbox "User $USERNAME added successfully" 8 45 --title "Success"
else
    whiptail --msgbox "Failed to add user $USERNAME" 8 45 --title "Error"
fi
exec ./main_menu.sh


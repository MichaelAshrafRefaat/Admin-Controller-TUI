#!/bin/bash

USERNAME=$(whiptail --inputbox "Enter username to delete:" 8 39 --title "Delete User" 3>&2 2>&1 1>&3)
sudo userdel -r $USERNAME
if [ $? -eq 0 ]; then
    whiptail --msgbox "User $USERNAME deleted successfully" 8 45 --title "Success"
else
    whiptail --msgbox "Failed to delete user $USERNAME" 8 45 --title "Error"
fi
exec ./main_script.sh

#!/bin/bash

# Check if the user is root
if [ "$(id -u)" -ne 0 ]; then
    whiptail --msgbox "You are not running this script as root." 8 50 --title "Permission Denied"
    
    # Prompt the user to switch to root
    if whiptail --yesno "Would you like to switch to root and rerun the script?" 8 50 --title "Switch to Root"; then
        
        # Ask for the root password
        PASSWORD=$(whiptail --passwordbox "Enter the root password:" 8 50 --title "Root Password" 3>&1 1>&2 2>&3)

        # Attempt to switch to root and rerun the script
        echo "$PASSWORD" | su -c "$0" root
        
        # Exit the script to prevent further execution in the non-root context
        exit 0
    else
        whiptail --msgbox "You chose not to switch to root. Exiting." 8 50 --title "Exit"
        exit 1
    fi
else
    whiptail --msgbox "You are running this script as root. Proceeding..." 8 50 --title "Permission Granted"
fi

# Continue with the rest of your script
whiptail --msgbox "hey root user" 8 50 --title "Welcome"
./main_menu.sh


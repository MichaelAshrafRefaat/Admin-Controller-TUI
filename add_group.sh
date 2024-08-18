#! /bin/bash    
GROUPNAME=$(whiptail --inputbox "Enter group name to add:" 8 39 --title "Add Group" 3>&2 2>&1 1>&3)
    sudo groupadd $GROUPNAME
    check_command_success "Group $GROUPNAME added successfully" "Failed to add group $GROUPNAME"
exec ./main_menu.sh 

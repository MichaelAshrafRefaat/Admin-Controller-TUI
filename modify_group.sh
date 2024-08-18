#! /bin/bash
GROUPNAME=$(whiptail --inputbox "Enter group name to modify:" 8 39 --title "Modify Group" 3>&2 2>&1 1>&3)
if [ $? != 0 ] || [ -z "$GROUPNAME" ]; then
            whiptail --msgbox "group does not exist please try again" 8 45 --title "Error"
            exec ./modify_group.sh
fi    
    if getent group $GROUPNAME &>/dev/null; then
        MODIFY_GROUP_OPTION=$(whiptail --title "Modify Group" --menu "Choose an option" 20 60 3 \
        "1" "Change Group Name" \
        "2" "Add User to Group" \
        "3" "Remove User from Group" 3>&2 2>&1 1>&3)



        if [ $? != 0 ]; then
		whiptail --msgbox "You will return to admin menu" 8 45 --title "warning"
            exec  ./main_menu.sh 
            
        fi

        case $MODIFY_GROUP_OPTION in
            1)
                NEW_GROUPNAME=$(whiptail --inputbox "Enter new group name:" 8 39 --title "Change Group Name" 3>&2 2>&1 1>&3)
                sudo groupmod -n $NEW_GROUPNAME $GROUPNAME
                #check_command_success "Group name changed to $NEW_GROUPNAME" "Failed to change group name"
		if [ $? -eq 0 ]; then
		
			whiptail --msgbox "$GROUPNAME CHANGED TO $NEW_GROUPNAME successfully" 8 45 --title "Success"
		else
    			whiptail --msgbox "Failed to change name of $GROUPNAME" 8 45 --title "Error"
		fi

                ;;
            2)
                USERNAME=$(whiptail --inputbox "Enter username to add to group:" 8 39 --title "Add User to Group" 3>&2 2>&1 1>&3)
                sudo usermod -aG $GROUPNAME $USERNAME
                if [ $? -eq 0 ]; then
                
			whiptail --msgbox "$USERNAME ADDED SUCCESFULLY TO  $GROUPNAME " 8 45 --title "Success"
                else
                        whiptail --msgbox "Failed tO ADD THIS $USERNAME TO $GROUPNAME" 8 45 --title "Error"
                fi

                ;;
            3)
                USERNAME=$(whiptail --inputbox "Enter username to remove from group:" 8 39 --title "Remove User from Group" 3>&2 2>&1 1>&3)
                sudo gpasswd -d $USERNAME $GROUPNAME
                 if [ $? -eq 0 ]; then
                
                        whiptail --msgbox "user $USERNAME removed" 8 45 --title "Success"
                else
                        whiptail --msgbox "Failed to remove user from $GROUPNAME" 8 45 --title "Error"
                fi

                ;;
        esac
    else
        error_message "Group $GROUPNAME does not exist"
    fi
exec ./main_menu.sh 

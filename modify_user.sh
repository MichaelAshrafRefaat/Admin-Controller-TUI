#! /bin/bash

# Your existing modify_user function code here


USERNAME=$(whiptail --inputbox "Enter username to modify:" 8 39 --title "Modify User" 3>&2 2>&1 1>&3)
if id "$USERNAME" &>/dev/null; then
   	MODIFY_OPTION=$(whiptail --title "Modify User" --menu "Choose an option" 30 60 10 \
        "1" "Change Username" \
        "2" "Change Password" \
        "3" "Change User ID" \
        "4" "Add User Information-comment" \
        "5" "Change Home Directory" \
        "6" "Change Login Shell" \
        "7" "disable user" \
        "8" "enable user" \
        "9" "Change Primary Group" \
        "10" "Add User to Secondary Group" \
	"11" "Back"      	3>&2 2>&1 1>&3)



	case $MODIFY_OPTION in

	    1)
 	        NEW_USERNAME=$(whiptail --inputbox "Enter new username:" 8 39 --title "Change Username" 3>&2 2>&1 1>&3)
                sudo usermod -l $NEW_USERNAME $USERNAME
                check_command_success "Username changed to $NEW_USERNAME" "Failed to change username"
                ;;
            2)
                USERNAME=$(whiptail --inputbox "Enter username to change password:" 8 39 --title "Change Password" 3>&2 2>&1 1>&3)
                sudo passwd $USERNAME
                check_command_success "Password for $USERNAME changed successfully" "Failed to change password for $USERNAME"
		;;
            3)
                NEW_UID=$(whiptail --inputbox "Enter new User ID:" 8 39 --title "Change User ID" 3>&2 2>&1 1>&3)
                sudo usermod -u $NEW_UID $USERNAME
                check_command_success "User ID changed to $NEW_UID" "Failed to change User ID"
                ;;
            4)
                NEW_GECOS=$(whiptail --inputbox "Enter new GECOS information:" 8 39 --title "Change GECOS" 3>&2 2>&1 1>&3)
                sudo usermod -c "$NEW_GECOS" $USERNAME
                check_command_success "GECOS information updated" "Failed to update GECOS"
                ;;
            5)
                NEW_HOME=$(whiptail --inputbox "Enter new Home Directory:" 8 39 --title "Change Home Directory" 3>&2 2>&1 1>&3)
                sudo usermod -d $NEW_HOME $USERNAME
                check_command_success "Home directory changed to $NEW_HOME" "Failed to change home directory"
                ;;
            6)
                NEW_SHELL=$(whiptail --inputbox "Enter new Login Shell:" 8 39 --title "Change Login Shell" 3>&2 2>&1 1>&3)
                sudo usermod -s $NEW_SHELL $USERNAME
                check_command_success "Login shell changed to $NEW_SHELL" "Failed to change login shell"
                ;;
            7)
 	        USERNAME=$(whiptail --inputbox "Enter username to enable:" 8 39 --title "Enable User" 3>&2 2>&1 1>&3)
    	        sudo usermod -U $USERNAME
    	        check_command_success "User $USERNAME enabled" "Failed to enable user $USERNAME"
		;;
            8)
    	        USERNAME=$(whiptail --inputbox "Enter username to enable:" 8 39 --title "Enable User" 3>&2 2>&1 1>&3)
    	        sudo usermod -L $USERNAME
    	        check_command_success "User $USERNAME enabled" "Failed to enable user $USERNAME"
		;;
            9)
                NEW_GROUP=$(whiptail --inputbox "Enter new Primary Group:" 8 39 --title "Change Primary Group" 3>&2 2>&1 1>&3)
                sudo usermod -g $NEW_GROUP $USERNAME
                check_command_success "Primary group changed to $NEW_GROUP" "Failed to change primary group"
                ;;
            10)
                SECONDARY_GROUP=$(whiptail --inputbox "Enter Secondary Group to add user to:" 8 39 --title "Add User to Secondary Group" 3>&2 2>&1 1>&3)
                sudo usermod -aG $SECONDARY_GROUP $USERNAME
                check_command_success "User $USERNAME added to secondary group $SECONDARY_GROUP" "Failed to add user to secondary group"
                ;;
	    11)

        esac
else
	error_message "User $USERNAME does not exist"
fi

exec ./main_menu.sh 

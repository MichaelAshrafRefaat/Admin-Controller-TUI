#!/bin/bash

# Enhanced Function to delete a group
delete_group() {
	whiptail --msgbox "No groups available for deletion." 8 50 --title "Error"

    # Get a list of groups with GID >= 1000 and format it for whiptail menu
    GROUPS=$(awk -F: '$3 >= 1000 {print $1}' /etc/group)
    
    # Check if there are any groups available for deletion
    if [ -z "$GROUPS" ]; then
        whiptail --msgbox "No groups available for deletion." 8 50 --title "Error"
        return
    fi
    
    # Convert the group list into a format suitable for the whiptail menu
    GROUPS_MENU=$(echo "$GROUPS" | awk '{print $1 " -"}')

    # Display the whiptail menu with available groups for deletion
    GROUPNAME=$(whiptail --title "Delete Group" --menu "Select a group to delete:" 15 50 6 $(echo $GROUPS_MENU) 3>&1 1>&2 2>&3)
    
    # Check if a group was selected
    if [ -n "$GROUPNAME" ]; then
        sudo groupdel "$GROUPNAME" && \
        whiptail --msgbox "Group $GROUPNAME has been deleted successfully." 8 50 --title "Success" || \
        whiptail --msgbox "Failed to delete group $GROUPNAME." 8 50 --title "Error"
    else
        whiptail --msgbox "No group selected. Returning to menu." 8 50 --title "Error"
    fi
}


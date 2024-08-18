#!/bin/bash

export NEWT_COLORS='
  root=red,black
  checkbox=blue,black
  button=white,black
  title=blue,grey
  roottext=white,black
'

while true; do
    CHOICE=$(whiptail --title "User and Group Management" --menu "Choose an option" 20 60 13 \
    "1" "Add User" \
    "2" "Modify User" \
    "3" "Delete User" \
    "4" "List Users" \
    "5" "List Groups" \
    "6" "Add Group" \
    "7" "Modify Group" \
    "8" "Delete Group" \
    "9" "Information about this Program" \
    "10" "Exit" 3>&2 2>&1 1>&3)

    case $CHOICE in
        1) bash add_user.sh ;;
        2) bash modify_user.sh ;;
        3) bash delete_user.sh ;;
        4) bash list_users.sh ;;
        5) bash list_groups.sh ;;
        6) bash add_group.sh ;;
        7) bash modify_group.sh  ;;
        8) bash delete_group.sh ;;
        9) bash info_about_program.sh ;;
        10) break ;;
    esac
    break;
done


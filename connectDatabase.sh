#!/bin/bash
echo "++++++Connect to Database++++++"
if [ $calledFromMenu -eq 1 ] 
then
     read -p "Enter DB name to connect to :" name
        if [ -d $dbPath/$name ]
        then
            DBdir=$name
        else
            read -p "Database doesn't exist press 1 to retry or 0 to go back to main menu :" x
            case $x in
            0) source ./Menu.sh
                ;;
            1) source ./connectDatabase.sh
                ;;
            esac
        fi
fi
echo "Connected to $DBdir successfully !"
PS3="$DBdir >"
select x in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Main menu"
do
    case $REPLY in
        1) source ./createTable.sh 
            ;;
        2) source ./listTables.sh
            ;;
        3) source ./dropTable.sh
            ;;
        4) source ./insertRecord.sh
            ;;
        5) source ./selectFromTable.sh
            ;;
        6) source ./deleteFromTable.sh
            ;;
        7) source ./updateTable.sh
            ;;
        8)  source ./Menu.sh
            ;;
    esac
done


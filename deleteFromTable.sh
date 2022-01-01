#!/bin/bash
read -p "Enter name of table : " tablename
#read -p "Enter name of primary key : " pkname
read -p "Enter the record number you want to delete : " recnum
if [ -f $tablename ]
    then
        awk -F: '{
                    if(FNR==recnum)
                        {
                            rm $0
                        } 
                }'
else
    read -p "Table doesn't exist >>
press 0 to go to previous menu
or 1 to go back to main menu 
or 2 to retry :" x
            case $x in
            0) calledFromMenu=0; 
               source ./connectDatabase.sh
                ;;
            1) source ./Menu.sh
                ;;
            2) source ./deleteFromTable.sh
                ;;
            esac
fi
#!/bin/bash
read -p "Enter the table name : " tb_name
read -p "Enter the column name : " co_name
if [ -f $dbPath/$DBdir/$tb_name ]
    then
        if [ -f $dbPath/$DBdir/$co_name ]
            then
                cat $dbPath/$DBdir/$tb_name/$co_name
fi
else
        read -p "Table or column doesn't exist >>
press 0 to go to previous menu
or 1 to go back to main menu 
or 2 to retry :" x
            case $x in
            0) calledFromMenu=0; 
               source ./connectDatabase.sh
                ;;
            1) source ./Menu.sh
                ;;
            2) source ./selectFromTable.sh
                ;;
            esac
fi
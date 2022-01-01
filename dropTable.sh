#!/bin/bash
echo "++++++Drop Table++++++"
read -p "Enter Table name:" tablename
if [ -f $dbPath/$DBdir/$tablename ]
then
    echo "Are you sure you want to delete $tablename ?"
    read -p "Press Y/y to confirm or anything else to exit: " choice
    case $choice in 
        [yY]) rm $dbPath/$DBdir/$tablename;
              echo "Removed Table $tablename ";
    esac
    calledFromMenu=0;
    source ./connectDatabase.sh
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
            2) source ./dropTable.sh
                ;;
            esac
fi
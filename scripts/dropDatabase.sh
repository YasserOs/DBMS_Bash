#!/bin/bash
function wrongAnswer () {
      read -p "Database doesn't exist press 1 to retry or 0 to go back to main menu :" x
            case $x in
            0) source ./Menu.sh
                ;;
            1) source ./dropDatabase.sh
                ;;
            esac
}
echo "++++++Drop Database++++++"
read -p "Enter DB name:" DBdir
if [[  $DBdir != +([a-zA-Z0-9]) ]]
then
    echo "Enter a correct name without special characters or spaces !"
    source ./dropDatabase.sh
elif [ -d $dbPath/$DBdir ]
then  
    echo "Are you sure you want to delete $DBdir ?"
    read -p "Press Y/y to confirm or anything else to exit: " choice
    case $choice in 
        [yY]) rm -r $dbPath/$DBdir;
              echo "==========================";
              echo "Removed database $DBdir successfully !";
              echo "=========================="
    esac
    source ./Menu.sh
else
  wrongAnswer
fi
#!/bin/bash
echo "++++++Drop Table++++++"
read -p "Enter Table name:" tablename
if test -f $tablename
then
    echo "Are you sure you want to delete $tablename ?"
    read -p "Press Y/y to confirm or anything else to exit: " choice
    case $choice in 
        [yY]) rm -r $dbPath/$tablename;
              echo "Removed database $tablename ";
    esac
else
echo "The table you entered Does not exist! "
fi
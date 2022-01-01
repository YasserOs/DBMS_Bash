#!/bin/bash
echo "++++++Create Database++++++"
read -p "Enter DB name:" DBdir
if  [[  $DBdir != +([a-zA-Z0-9]) ]] 
then
    echo "Database can't contain special characters"
else
    if [ -d $dbPath/$DBdir ]
    then    
        echo "Database $DBdir already exists !"
        source ./createDatabase.sh
    else
        mkdir $dbPath/$DBdir
        calledFromMenu=0
        echo "Created $DBdir successfully !"
        source ./connectDatabase.sh
    fi
fi



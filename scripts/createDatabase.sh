#!/bin/bash
echo "++++++Create Database++++++"
read -p "Enter DB name:" DBdir
if [[ $DBdir != +([a-zA-Z_]*[a-zA-Z0-9_]) || $DBdir == *" "*  ]] 
then
    echo "Database can't contain special characters"
    source ./createDatabase.sh
    
elif [ -d $dbPath/$DBdir ]
then    
        echo "Database $DBdir already exists !"
        source ./createDatabase.sh
else
    mkdir $dbPath/$DBdir
    calledFromMenu=0
    echo "Created $DBdir successfully !"
    sleep 1
    source ./connectDatabase.sh
    
fi


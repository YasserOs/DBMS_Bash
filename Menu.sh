#!/bin/bash
dbPath=$HOME/project/DBMS_Bash/dbs
typeset -i calledFromMenu=1

PS3="Enter choice > "
echo "========================="
echo ":Welcome To J&Y Database:"
echo "========================="

select x in "Create Database" "List Databases" "Connect to Database" "Drop Database"
do
	case $REPLY in 
		1) source ./createDatabase.sh
			;;
		2)  source ./listDatabases.sh
			;;
		3) source ./connectDatabase.sh
			;;
        4) source ./dropDatabase.sh
            ;;
	esac
done

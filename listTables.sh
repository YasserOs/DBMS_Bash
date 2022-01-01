#!/bin/bash
echo "List of Tables in $DBdir :"
ls $dbPath/$DBdir
echo "================"
calledFromMenu=0
sleep 3
source ./connectDatabase.sh
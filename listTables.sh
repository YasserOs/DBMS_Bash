#!/bin/bash
echo "========================="
echo "List of Tables in $DBdir :"
ls $dbPath/$DBdir
echo "========================="
calledFromMenu=0
sleep 1
source ./connectDatabase.sh
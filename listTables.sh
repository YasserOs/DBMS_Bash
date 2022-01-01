#!/bin/bash
echo "List of Tables in $DBdir :"
ls $dbPath/$DBdir
echo "================"
calledFromMenu=0
source ./connectDatabase.sh
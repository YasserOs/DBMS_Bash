#!/bin/bash
typeset -i n=0
typeset -i m=1
let columns_array[$n]
let datatypes_array[$n]
read -p "Enter table name : " tbname
if [ -f $dbPath/$DBdir/$tbname ]
        then
	    for i in $dbPath/$DBdir/$tbname
		do 
		  datatypes_array[$i]= cut -d: -f$m $dbPath/$DBdir/$tbname
		  m=$m+1
		done
echo ${datatypes_array[@]}
sleep 3
#echo ${datatypes_array[@]}
#echo ${z[@]}
#sleep 3
calledFromMenu=0
source ./connectDatabase.sh

                        
else
    read -p "Table doesn't exist , 
    press 0 to go back to previous menu 
    or 1 to go to main menu 
    or 2 to retry :" x
            case $x in
            0)  calledFromMenu=0;
                source ./connectDatabase.sh
                ;;
            1) source ./Menu.sh
                ;;
            2) source ./insertRecord.sh
                ;;
            esac
fi
    

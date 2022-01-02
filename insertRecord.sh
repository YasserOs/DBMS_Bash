#!/bin/bash
typeset -i i=2 ## i starts from 2nd line as th 1st contains number of columns
typeset -i fn=1 ## field number
let columns_array[0]
let datatypes_array[0]
read -p "Enter table name : " tbname
if [ -f $dbPath/$DBdir/$tbname ]
        then
        typeset -i numFields=$(head -n 1 $dbPath/$DBdir/$tbname)
        echo "$numFields"
        while test $i -le 3
        do
            fn=1
            ## we need to store the number of fields in the table file to loop over it 
            ## so 4 here needs to be the number of fields in the table 
            while test $fn -le $numFields
            do 
                ## i =2 means 2nd line , fill datatypes array
                ## i =3 3rd line fill columns array
                if [ $i -eq 2 ]
                then
                    datatypes_array[$fn-1]=$(head -n $i $dbPath/$DBdir/$tbname | tail -n 1 |  cut -d: -f$fn)
                else
                    columns_array[$fn-1]=$(head -n $i $dbPath/$DBdir/$tbname | tail -n 1 | cut -d: -f$fn) 
                fi
                fn=$fn+1
            done
            i=$i+1
        done
echo ${datatypes_array[@]}
echo ${columns_array[@]}
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
    

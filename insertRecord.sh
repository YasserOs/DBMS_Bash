#!/bin/bash
typeset -i n=0
typeset -i i=1
let columns_array[$n]
let datatypes_array[$n]
read -p "Enter table name : " tbname
if [ -f $dbPath/$DBdir/$tbname ]
        then
            awk -F: '{if(i<=NF)
                        {
                            if(NR==1)
                                {
                                    datatypes_array[$n]=$i;       
                                }
                            else if (NR==2)
                                {
                                    columns_array[$n]=$i;
                                }
                                i=i+1;
                                n=$n+1;
                                print n;
                        }
                            n=0; i=0;
                    }' $dbPath/$DBdir/$tbname
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
        echo "${columns_array[*]}"
#!/bin/bash
typeset -i fn=1
typeset -i column_found=0
typeset -i currentrecord=4
read -p "Enter table name : " tabname
total=`cat $dbPath/$DBdir/$tabname | wc -l`
typeset -i fieldnum=$(head -n 1 $dbPath/$DBdir/$tabname)
recordss=$(( total - 3 ))
if [ -f $dbPath/$DBdir/$tabname ]
        then
        select x in "Select all records " "Select a certain field"
        do  
            case $REPLY in
            1) cat $dbPath/$DBdir/$tabname | tail -n $recordss;
                break
                ;;
            2) while true
                do
                    read -p "Enter name of column : " cname
                    while test $fn -le $fieldnum
                    do
                        if [ "$cname" == "$(head -n 3 $dbPath/$DBdir/$tabname | tail -n 1 | cut -d: -f$fn)" ]
                        then
                        column_found=1
                        break
                        else
                        column_found=0
                        fi
                        fn=$fn+1
                    done
                    if [ $column_found -eq 1 ]
                    then
                        break
                    else
                        echo "Column name does not exist!"
                    fi
                done;
                while test $currentrecord -le $total
                do
                match_value=`cat $dbPath/$DBdir/$tabname | head -n $currentrecord | tail -n 1 | cut -d: -f$fn`
                echo "$currentrecord : $match_value"
                currentrecord=$currentrecord+1
                done;
                break
                ;;
                esac
            done
            fi































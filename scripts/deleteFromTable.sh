#!/bin/bash
function checkColumnExists () {


    fieldnum=$(head -n 1 $dbPath/$DBdir/$tablename)
    while true
    do
        read -p "Enter name of column : " columnname
        while test $fn -le $fieldnum
        do
            if [ "$columnname" == "$(head -n 3 $dbPath/$DBdir/$tablename | tail -n 1 | cut -d: -f$fn)" ]
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
    done
}

function deleteRecord () {
    value_found=0
    typeset -i current_record=4
    read -p "Enter value : " x
    lines=$(cat $dbPath/$DBdir/$tablename | wc -l)
    while test $current_record -le $lines
    do
        match_column=`cat $dbPath/$DBdir/$tablename | head -n $current_record | tail -n 1 | cut -d: -f$fn`
        if [ "$match_column" == "$x" ]
        then
            match_record=`cat $dbPath/$DBdir/$tablename | head -n $current_record | tail -n 1`
            sed -i '/'"$match_record"'/d' $dbPath/$DBdir/$tablename
            echo "Deleted $match_record Successfully !"
            current_record=$current_record-1
            value_found=1
        fi
        current_record=$current_record+1
    done
    if [ $value_found -eq 0 ]
    then
        echo "The value you entered does not exist!"
        deleteRecord
    fi
}
typeset -i fn=1
typeset -i column_found=0

read -p "Enter name of table : " tablename
if [ -f $dbPath/$DBdir/$tablename ]
    then
    checkColumnExists
    deleteRecord

fi
    
        
        
        
        
 
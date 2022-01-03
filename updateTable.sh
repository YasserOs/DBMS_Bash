#!/bin/bash
function checkColumnExists () {


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

function updateRecord () {
    lines=$(cat $dbPath/$DBdir/$tablename | wc -l)
    while test $current_record -le $lines
    do
        match_column=`cat $dbPath/$DBdir/$tablename | head -n $current_record | tail -n 1 | cut -d: -f$fn`
        if [ "$match_column" == "$oldvalue" ]
        then
            match_record=`cat $dbPath/$DBdir/$tablename | head -n $current_record | tail -n 1`
            i=1
            while test $i -le $fieldnum  
            do
                field=`cat $dbPath/$DBdir/$tablename | head -n $current_record | tail -n 1 | cut -d: -f$i`
                if [ $i -eq $fn ]
                then
                    if [ $i -eq 1 ]
                    then
                        newrecord="$newvalue"
                    else
                        newrecord="$newrecord:$newvalue"
                    fi
                else
                    if [ $i -eq 1 ]
                    then
                        newrecord="$field"
                    else
                        newrecord="$newrecord:$field"
                    fi
                fi
                i=$i+1
            done
            sed -i 's/'"$match_record/$newrecord"'/g' $dbPath/$DBdir/$tablename
            echo "Updated Old Record : $match_record to -> New Record : $newrecord "
            newrecord=""
        fi
        current_record=$current_record+1
    done

}
typeset -i fieldnum=0
typeset -i fn=1
typeset -i i=1
typeset -i column_found=0
typeset -i current_record=4
newrecord=""
read -p "Enter name of table : " tablename
if [ -f $dbPath/$DBdir/$tablename ]
    then
    fieldnum=$(head -n 1 $dbPath/$DBdir/$tablename)
    checkColumnExists
    read -p "Enter value to be updated : " oldvalue
    read -p "Enter new value : " newvalue
    updateRecord
    
fi
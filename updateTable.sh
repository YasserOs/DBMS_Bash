#!/bin/bash
function initializePK () {
     rec_num=$(cat $dbPath/$DBdir/$tablename | wc -l)
        typeset -i r=4
        while test $r -le $rec_num
        do
            pkarray[$r]=$(cat $dbPath/$DBdir/$tablename | head -$r | tail -1 | cut -d: -f1)
            r=$r+1
        done
}

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
	    if [ $fn -eq 1 ]
	    then
		initializePK
	    fi
            break
        else
            echo "Column name does not exist!"
        fi
    done
}

function updateRecord () {
    read -p "Enter value to be updated : " oldvalue
    read -p "Enter new value : " newvalue
    if [ $fn -eq 1 ]
    then
	for i in "${pkarray[@]}"
	do
	  if [ $i = $newvalue ] 
	  then
	      echo " There is a primary key with the same value"
	      sleep 1
	      updateRecord
	  fi
	done
    fi
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
let pkarray[0]
newrecord=""
read -p "Enter name of table : " tablename
if [ -f $dbPath/$DBdir/$tablename ]
    then
    fieldnum=$(head -n 1 $dbPath/$DBdir/$tablename)
    checkColumnExists
    updateRecord
    
fi

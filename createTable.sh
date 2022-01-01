#!/bin/bash
typeset -i n=0
let columns[$n]
columnsString
dataTypes
read -p "Enter table name :" tbname
if [ -f $dbPath/$DBdir/$tbname ]
then
    echo "Table $tbname already exists !"
    source ./createTable.sh
else
    ## takes primary key name and data type
    read -p "Enter name of primary key :" pk
    columns[$n]="$pk"
    columnsString="$pk"
    echo "Choose type :"
    select x in "Int" "String"
    do
        case $x in
            "Int") dataTypes="Int";
                    break
                ;;
            "String") dataTypes="String";
                    break
                ;;
        esac
    done

    ## increment n by 1 since primary key is already inserted
    n=$n+1

    ## takes the other columns
    read -p "Enter number of columns :" num
    while test $n -le $num
    do
        let columnFound=0
        ## validation loop to check if the column name inserted exists in the columns array or not
        while true
        do
            read -p "Enter name of column $n :" name
            for i in "${columns[@]}"
            do 
                if  [ "$i" == "$name" ]  
                then     
                    echo "column exists !"
                    columnFound=1
                    break
                else
                    columnFound=0
                fi
            done
            if [ $columnFound -eq 0 ]
            then
                break
            fi
        done
        ### end of validation loop

        ### inserting the column name in the array , and concatenating it to the columnsString so it looks like name1:name2:name3
        columns[$n]=$name
        columnsString="$columnsString:$name"
        echo "Choose type :"
        select x in "Int" "String"
        do
            case $x in
                "Int") dataTypes="$dataTypes:Int";
                        break
                    ;;
                "String") dataTypes="$dataTypes:String";
                        break
                    ;;
            esac
        done
        n=$n+1
    done
fi
## creating file for the table and redirecting echo to the file by >> to append a new line

touch $dbPath/$DBdir/$tbname
echo $dataTypes >> $dbPath/$DBdir/$tbname
echo $columnsString >> $dbPath/$DBdir/$tbname

## resetting the flag to call the previous menu
calledFromMenu=0
source ./connectDatabase.sh
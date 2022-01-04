#!/bin/bash
#create table
function createTable () {
    touch $dbPath/$DBdir/$tbname
    typeset -i numColumns=$numColumns+1
    echo $numColumns >> $dbPath/$DBdir/$tbname
    echo $dataTypes >> $dbPath/$DBdir/$tbname
    echo $columnsString >> $dbPath/$DBdir/$tbname

    echo "=============================="
    echo "Table created successfully!"
    echo "=============================="
    sleep 1
}
function readPK () {
    read -p "Enter name of primary key :" pk
    columns[$n]="$pk"
    columnsString="$pk"
    if [[ $pk != +([a-zA-Z]*[a-zA-Z0-9]) || $pk == *" "* ]]
        then
            echo "Primary key can not contain special characters"
            readPK 
    fi
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
}
function readColumns () 
    read -p "Enter number of columns :" numColumns
    if [[ $numColumns == 0 || $numColumns != +([0-9]) || $numColumns == *" "* ]]
    then
        echo "Invalid column number"
        readColumns 
    fi

    while test $n -le $numColumns
    do
        let columnFound=0
        ## validation loop to check if the column name inserted exists in the columns array or not
        while true
        do
            read -p "Enter name of column $n :" name
            if [[ $name != +([a-zA-Z_]*[a-zA-Z0-9_]) || $name == *" "* ]]
                then
                    echo "Invalid column name"
                    continue 
            fi
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
}
typeset -i n=0
let columns[$n]
let columnsString
let dataTypes
read -p "Enter table name :" tbname
if [[  $tbname != +([a-zA-Z_]*[a-zA-Z0-9_]) || $tbname == *" "* ]] 
then
    echo "Table can't contain special characters"
    source ./createTable.sh
elif [[ -f $dbPath/$DBdir/$tbname ]] 
then
    echo "Table $tbname already exists !"
    source ./createTable.sh
else
    ## takes primary key name and data type
    readPK
    ## increment n by 1 since primary key is already inserted
    n=$n+1
    ## takes the other columns
    readColumns
fi
## creating file for the table and redirecting echo to the file by >> to append a new line
createTable

calledFromMenu=0
source ./connectDatabase.sh
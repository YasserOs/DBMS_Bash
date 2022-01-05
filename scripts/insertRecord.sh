#!/bin/bash
shopt -s extglob
export LC_COLLATE=C 
function initializeArrays () {
    while test $i -le 3
        do
            fn=1 
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

}

function initializePK () {
     rec_num=$(cat $dbPath/$DBdir/$tbname | wc -l)
        typeset -i r=4
        while test $r -le $rec_num
        do
            pk_array[$r]=$(cat $dbPath/$DBdir/$tbname | head -$r | tail -1 | cut -d: -f1) 
            r=$r+1
        done
}

function validateInput () {
    while true 
        do  
            read -p "enter data for ${columns_array[$n]} with type ${datatypes_array[$n]} : "  x

            ### primary key validation

                    if [ $n -eq 0 ]
                    then
                        for i in "${pk_array[@]}"
                        do
                            if [ "$x" == "$i" ]
                            then
                                echo "primary key $i already exists!"
                                pk_found=1
                                break
                            else
                                pk_found=0
                            fi
                        done
                        if [ $pk_found -eq 1 ]
                        then
                            continue
                        fi
                    fi
                    
            ### end of validation

                    if [ "${datatypes_array[$n]}" == "String" ]
                        then
                            case $x in 
                                +([a-zA-Z_]*[a-zA-Z0-9_@])) if [ $n -eq 0 ] 
                                             then 
                                             input_record="$x"
                                             else 
                                             input_record="$input_record:$x"
                                             fi;
                                             break
                                             ;;
                                        *)  echo "Invalid string!" 
                                            continue
                                             ;; 
                            esac

                    elif [ "${datatypes_array[$n]}" == "Int" ]
                        then
                            case $x in 
                                +([0-9])) if [ $n -eq 0 ] 
                                          then 
                                          input_record="$x"
                                          else 
                                          input_record="$input_record:$x"
                                          fi;
                                          break
                                          ;;
                                     *) echo "please enter an integer!"
                                        continue
                                           ;; 
                            esac
                    fi
        done
}

function writeToFile () {
    echo $input_record >> $dbPath/$DBdir/$tbname
    echo "=============================="
    echo "Record inserted successfully!"
    echo "=============================="
    sleep 1
}
function wrongAnswer () {
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
}
typeset -i i=2 ## i starts from 2nd line as th 1st contains number of columns
typeset -i fn=1 ## field number
typeset -i pk_found=0
let columns_array[0]
let datatypes_array[0]
let pk_array[0]
input_record=""
read -p "Enter table name : " tbname
if [ -f $dbPath/$DBdir/$tbname ]
then
    typeset -i numFields=$(head -n 1 $dbPath/$DBdir/$tbname)
    initializeArrays
    initializePK
    typeset -i n=0
    while test $n -lt $numFields
    do
        validateInput
        n=$n+1
    done
    writeToFile
    calledFromMenu=0
    source ./connectDatabase.sh
       
else
  wrongAnswer
fi
    

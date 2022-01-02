#!/bin/bash
shopt -s extglob
export LC_COLLATE=C 
typeset -i i=2 ## i starts from 2nd line as th 1st contains number of columns
typeset -i fn=1 ## field number
let columns_array[0]
let datatypes_array[0]
let pk_array[0]
input_record=" "
read -p "Enter table name : " tbname
if [ -f $dbPath/$DBdir/$tbname ]
        then
        typeset -i numFields=$(head -n 1 $dbPath/$DBdir/$tbname)
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
        
        file=$(cat $dbPath/$DBdir/$tbname | wc -l)
        rec_num=$(( file - 3 ))
        records=$(tail -n $rec_num $dbPath/$DBdir/$tbname)
        typeset -i r=1
        while test $r -le $rec_num
            do
                pk_array[$r]= head -n $r $records | tail -n 1 
                r=$r+1
            done

    ###end of data retrieval (pks , datatypes , columns)
    echo ${columns_array[@]}
    typeset -i n=0
    while test $n -lt $numFields
    do
        while true 
        do  
            if [ $n -eq 0 ]
            read -p "enter data for ${columns_array[$n]} with type ${datatypes_array[$n]} : "  x
                    if [ "${datatypes_array[$n]}" == "String" ]
                        then
                            case $x in 
                                +([a-zA-Z])) input_record="$input_record:$x";
                                             break
                                             ;;
                                        *)  echo "please enter a string without any special characters" 
                                            continue
                                             ;; 
                            esac

                    elif [ "${datatypes_array[$n]}" == "Int" ]
                        then
                            case $x in 
                                +([0-9])) input_record="$input_record:$x";
                                           break
                                           ;;
                                     *) echo "please enter an integer!"
                                        continue
                                           ;; 
                            esac
                    fi
        done
            n=$n+1
    done
    
echo $input_record
sleep 3
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
    

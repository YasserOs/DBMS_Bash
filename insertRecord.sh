#!/bin/bash
typeset -i n=0
#typeset -i m=0
let columns_array[$n]
let datatypes_array[$n]
read -p "Enter table name : " tbname
if [ -f $dbPath/$DBdir/$tbname ]
        then
            y=($(awk -F: '{for (i=1;i<=NF;++i)
                            {   
                                if(NR==1)
                                    {
                                        datatypes_array[i-1]=$i;
                                        print datatypes_array[i-1];
                                    }                           
               		    }  
                        }' $dbPath/$DBdir/$tbname))
            z=($(awk -F: '{for (i=1;i<=NF;++i) 
                            {           
                                if(NR==2)
                                    {
                                        columns_array[i-1]=$i;
                                        print columns_array[i-1];
                                    }
                            }
                        }' $dbPath/$DBdir/$tbname))
echo ${datatypes_array[@]}
echo ${z[@]}
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
    

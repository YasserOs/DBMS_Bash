#!/bin/bash
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
            2) source ./selectFromTable.sh
                ;;
            esac
}
function selectfromfield ()
{
   awk -F: '        BEGIN { 
                        printf "Enter name of field :"
                        getline field < "-"
                        printf "Press 0 to show the field only or 1 to show the whole record : "
                        getline show_whole_record < "-"
                        if (show_whole_record==1){
                        printf "Enter value :"
                        getline value < "-"}
                        value_found=0
                        fieldNum=0 
                    }   

                    {   if(NR==3){
                            for(i=1;i<=NF;i++){
                                if(field==$i)
                                {
                                    fieldNum=i
                                    if(show_whole_record==0){
                                        printf("%s\n",$fieldNum)
                                    }
                                    else{
                                    printf ("%s\n",$0)
                                    }
                                    break
                                }
                            }
                        }
                        if(fieldNum!=0){
                            if(NR>3){
                                if(show_whole_record==1){
                                    if(value==$fieldNum){
                                        printf ("%s\n",$0)
                                        value_found=1
                                    }
                                }
                                else{
                                    value_found=1
                                    printf("%s\n",$fieldNum)
                                }   
                            }
                        }
                    }
                    END { if(fieldNum==0){
                                printf "Field not found !\n"
                            }
                          if(value_found==0){
                                printf "Value not found !\n"
                          }
                    
                    }' $dbPath/$DBdir/$tabname
   
}
read -p "Enter table name : " tabname
if [ -f $dbPath/$DBdir/$tabname ]
        then
        select x in "Select all records " "Select a certain field" "Return to previous menu"
        do  
            case $REPLY in
            1) cat $dbPath/$DBdir/$tabname | awk '{if(NR>2) print $0}'
                ;;
            2) selectfromfield;
               ;;
            3)  calledFromMenu=0;
                source ./connectDatabase.sh
                ;;
            esac
        done
else
    wrongAnswer
fi
    





























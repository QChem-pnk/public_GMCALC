#!/bin/bash

#***********
#FUNCTIONS
#Function to check if folder exists
function chkfld {
       if [ ! -d $1 ]
       then
           mkdir $1
       fi
}

function dummy_del {
        #If dummy exists, remove
        if [ -f dummytxt ]
        then
          rm dummytxt
        fi
}

function interrupt_c {
        dummy_del
        clear
        for i in `seq 0 9`;do
             echo -e "${megaman[$i]}"
        done
        echo -e "\e[34m${megaman[10]}\e[0m"
        echo -e "\n$last_thing"
        echo -e "\nThe program has been \e[33minterrumpted\e[0m.\n"
        exit
}

#Function to call error
function inperr {
         echo -e "\n\e[5;31mERROR\e[0m\nNo such option."
         sleep 2
         echo -ne "\n\r\e[5mChoose a number from the menu."
         sleep 1
         echo -ne "\r\e[K \e[0m"
         break
}


#Funtion to finish and echo
function completecho {
                  echo -e "\nPress a key to continue."
                  read input
                  clear
                  break
}


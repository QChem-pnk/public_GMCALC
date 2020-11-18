#!/bin/bash

PS3="
:: Choose an option > "

colorch=""

last_thing="Nothing done."

#Defining colors
dfltc="\e[0m"
ccode="\e[3"
bcode="\e[9"
ncode="\e["

black="0m"
red="1m"
green="2m"
yellow="3m"
blue="4m"
purple="5m"
cyan="6m"
white="9m"

function altcolor {
       #If number is even
       if [ `expr $1 % 2` -eq 0 ]
       then
         #normal colors
         bred="\e[31m"
         bgreen="\e[32m"
         byellow="\e[33m"
         bblue="\e[34m"
         bpurple="\e[35m"
         bcyan="\e[36m"
       else
         #bright colors
         bred="\e[91m"
         bgreen="\e[92m"
         byellow="\e[93m"
         bblue="\e[94m"
         bpurple="\e[95m"
         bcyan="\e[96m"
       fi
}


#Function to draw the menu
function menugm {
   #Color selection
   case $2 in
     0)
        colorch=$cyan
     ;;
     1)
        colorch=$blue
     ;;
     2)
        colorch=$red
     ;;
     3)
        colorch=$green
     ;;
     4)
        colorch=$yellow
     ;;
     5)
        colorch=$purple
     ;;
     6)
        colorch=$white
     ;;
   esac

   #Define sections
   selection[0]="${bcode}${colorch}*            ${ccode}${colorch}MAIN  MENU${bcode}${colorch}            *${dfltc}"
   selection[1]="${bcode}${colorch}*             ${ccode}${colorch}GAUSSIAN${bcode}${colorch}             *${dfltc}"
   selection[2]="${bcode}${colorch}*              ${ccode}${colorch}MOPAC${bcode}${colorch}               *${dfltc}"
   selection[3]="${bcode}${colorch}*        ${ccode}${colorch}MOLECULE  & METHOD${bcode}${colorch}        *${dfltc}"
   selection[4]="${bcode}${colorch}*             ${ccode}${colorch}MOLECULE${bcode}${colorch}             *${dfltc}"
   selection[5]="${bcode}${colorch}*         ${ccode}${colorch}GAUSSIAN  METHOD${bcode}${colorch}         *${dfltc}"
   selection[6]="${bcode}${colorch}*          ${ccode}${colorch}MOPAC  RESULTS${bcode}${colorch}          *${dfltc}"
   selection[7]="${bcode}${colorch}*         ${ccode}${colorch}GAUSSIAN  OPTION${bcode}${colorch}         *${dfltc}"

   #All prompts to construct the table
   separ="${bcode}${colorch}*                                  *${dfltc}"
   finln="${bcode}${colorch}************************************${dfltc}"
   creatorln="${bcode}${colorch}*              ${ncode}2;9${black}by PNK${dfltc}${bcode}${colorch}              *${dfltc}"
   programnm="${bcode}${colorch}*              ${ccode}${purple}GMCALC${dfltc}${bcode}${colorch}              *${dfltc}"
   vnmbr="${bcode}${colorch}*              ${ncode}2;3${purple}${versionnmb}${dfltc}${bcode}${colorch}              *${dfltc}"
   selectoptch="${bcode}${colorch}*              ${ccode}${colorch}SELECT${bcode}${colorch}              *${dfltc}"
   mopac2="${bcode}${colorch}*     ${ccode}${colorch}Molecular Orbit  PACkage${bcode}${colorch}     *${dfltc}"
   separi="                                    ${dfltc}"

   megaman[0]="\e[34m            ▄▄█▀▀▄    \e[0m"
   megaman[1]="\e[34m          ▄█████▄▄█▄    \e[0m"
   megaman[2]="\e[34m       ▄▄▄▀██████▄▄██    \e[0m"
   megaman[3]="\e[34m    ▄██░░█░█▀░░▄▄▀█░█   ▄▄▄▄\e[0m"
   megaman[4]="\e[34m  ▄█████░░██░░░▀▀░▀░█▀▀██▀▀▀█▀▄\e[0m"
   megaman[5]="\e[34m  █████░█░░▀█░▀▀▀▀▄▀░░░███████▀\e[0m"
   megaman[6]="\e[34m   ▀▀█▄ ██▄▄░▀▀▀▀█▀▀▀▀▀ ▀▀▀▀\e[0m"
   megaman[7]="\e[34m   ▄████████▀▀▀▄▀    \e[0m"
   megaman[8]="\e[34m  ██████░▀▀█▄░░░█▄    \e[0m"
   megaman[9]="\e[34m   ▀▀▀▀█▄▄▀ ██████▄    \e[0m"
   megaman[10]="           █████████    "

   i=$menuslb
   echo -ne "${finln}\n${separ}${megaman[0]}\n${programnm}${megaman[1]}\n${vnmbr}${megaman[2]}\n${creatorln}${megaman[3]}\n${separ}${megaman[4]}\n${selection[$i]}${megaman[5]}"
   #Draw depending on menu
    if [ "$i" -eq 2 ]
    then
      echo -ne "\n${mopac2}"
    elif [ "$i" -gt 2 -a "$1" -ne 6 ]
    then
      echo -ne "\n${selectoptch}"
    elif [ "$i" -eq 6 ]
    then
      echo -ne "\n${mopac2}"
    else
      echo -ne "\n${separ}"
    fi
      echo -ne "${megaman[6]}\n${separ}${megaman[7]}\n${finln}${megaman[8]}\n${separi}${megaman[9]}\n"
   #Show molecules and methods
   if [ "$molec" = "" ]
   then
     printf "\e[34m%-10s \e[91m%-36s\e[0m \e[34m%-20s\e[0m\n" "Molecule:" "NONE" ${megaman[10]}
   else
     printf "\e[34m%-10s \e[94m%-36s\e[0m \e[34m%-20s\e[0m\n" "Molecule:" $molec ${megaman[10]}
   fi
   if [ "$methodlong" = "" ]
   then
      printf "\e[36m%-16s \e[91m%-14s\e[0m\n" "GAUSSIAN method:" "NOT SELECTED"
   else
      printf "\e[36m%-16s \e[96m%-14s\e[0m\n" "GAUSSIAN method:" $methodlong
   fi
   if [ "$methodmoplong" = "" ]
   then
       printf "\e[36m%-16s \e[91m%-18s\e[0m\n" "MOPAC method:" "NOT SELECTED"
   else
       printf "\e[36m%-16s \e[96m%-18s\e[0m\n" "MOPAC method:" $methodmoplong
   fi
   truebox="\e[42m"
   falsebox="\e[41m"

   if [ "$opt_geom" = "true" ]
   then
      opt_geombox=$truebox
   else
      opt_geombox=$falsebox
   fi
   if [ "$freq" = "true" ]
   then
      freqbox=$truebox
   else
      freqbox=$falsebox
   fi

   #Show gaussian method options
   if [ "$molec" = "" ]
   then
      echo -e "\n\e[31mSelect the molecule.\e[0m\n"
   elif [ $i -eq 7 -o $i -eq 5 -o $i -eq 1 ]
   then
      printf "\n\e[92m%12s \e[0m%3s   %4s %3s\n" "Options:    " " _ " "    " " _ "
      printf "\e[0m%12s |${opt_geombox}%1s\e[0m|   %4s |${freqbox}%1s\e[0m|\n" "   opt geom:" "_" "freq" "_"
   else
      echo -e "\n\n"
   fi
   #Prompt last thing done
   echo -e "\n\e[36mLOG:\e[0m $last_thing\n"
}


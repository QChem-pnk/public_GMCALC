#!/bin/bash


#Check files in folder with a determined extension
function chkf_d {
        ghm=""
        i=-1
        while [ "$i" -lt "$3" ]
        do
          ghm=$ghm/*
          i=`expr $i + 1`
        done
        chk_path="${1}${ghm}.${2}"
        #Anyfile var is number of .$2 files in $1 directory
        anyfile=`ls $chk_path | wc -w`
        #If there's files
        if [ "$anyfile" -gt 0 ]
        then
            #Save list of names in dummytxt
            ls $chk_path | awk -F . '{print $1}' | awk -F / '{print $NF}' | awk -F _ '{print $1}' >> dummytxt 2>/dev/null
        fi
}

function get_all_molecules {
        dummy_del
        case $1 in
        1 | 0)
          chkf_d ${com_fld} com 0
          chkf_d ${gjf_fld} gjf 0
        ;;&
        2 | 0)
          chkf_d ${log_fld} log 0
          for i in arc out mop
          do
             chkf_d ${mopac_fld} $i 1
          done
        ;;
        esac
}


#Function select molecule
function askingmol {
#Loop to chose molecule
while [ 0 ]
do
  clear
  menutmp=$menuslb
  menuslb=3
  menugm 4 3
  echo -e "Input the molécula or input \e[31m'0'\e[0m to select a preexisting molecule:\n"
  read molec
  if [ "$molec" = "0" ]
  then
        get_all_molecules $1
        #if dummytext is bigger than 0
        if [ -s dummytxt ]
        then
           #files is an array with all the molecules
           files=()
           files=`sort -u dummytxt`
           files+=("ALL")
          while [ 0 ]
          do
           #initialize i
           i=1
           echo -e "\nAvailable molecules:\n"

           #Option to exit
           echo "0 - EXIT"

           # for every molecule in var files
           for j in ${files[@]}
           do
             #print number - molecule
             echo "$i - $j"
             #new array
             file[i]=$j
             i=$(( i + 1 ))
           done
           #Input file name
           echo -e "\nInput the molecule number or \e[31m'0'\e[0m to continue.\n"
           read input

           #If 0, exit
           if [ "$input" = 0 ]
           then
                molec=""
                break
           fi

           #Set molec name by input tmp number
           molec=${file[$input]}
           #If number belonged to a molec
           if [ ! -z "$molec" ]
           then
             dummy_del
             break
           fi
           #If it didn't correspond, keep looping
           echo -e "\nNot a valid value.\n"
          done
        #If there's no molecules
        else
           echo -e "\n\e[31mNo avalaible molecules.\e[0m Back to menu.\n"
           dummy_del
           sleep 2
           break
        fi
   fi
   if [ "$input" = [aA][lL][lL] ]
   then
      molec="ALL"
   fi

   #Display chosen molecule
   if [ "$input" = 0 ]
   then
     echo -e "\nNo\e[32m molécula\e[0m has been selected.\n"
     break
   else
     echo -e "\nMolecule \e[94;5m${molec}\e[0m has been selected.\n"
     break
   fi

 done
}

#Function to change molecule. 0 Gaussian - 1 MOPAC
function askingmethod {
#Ask method menu
  clear
  menutmp=$menuslb
  menuslb=3
  menunm=`expr $1 + 5`
  if [ $1 = 0 ]
  then
     menugm $menunm 1
  else
     menugm $menunm 2
  fi
  echo -e "Input the ${calcpr[$1]} method or escribe \e[31m'0'\e[0m para seleccionar de una lista.\n"
  read methodtmp
  #If select is introduced
  if [ "$methodtmp" = "0" ]
  then
     while [ 0 ]
     do
        i=1

        echo -e "\nAvailable methods:\n"

        echo "0 - EXIT"
        for j in ${metodos[@]}
        do
          echo "$i - $j"
          metod[i]=$j
          i=$(( i + 1 ))
        done

        echo -e "\nInput the method number or \e[31m'0'\e[0m to continue.\n"
        read input
        if [ "$input" = 0 ]
        then
           methodtmp=""
           break
        fi
        #Set method name by input tmp number
        methodtmp=${metod[$input]}
        #If number belonged to a method
        if [ ! -z "$methodtmp" ]
        then
          break
        fi
      done
  fi

  #Display selected method, or none
  if [ "$input" = 0 ]
  then
    echo -e "\nNo \e[32m${calcpr[$1]} method\e[0m has been selected.\n"
  else
    echo -e "\n${calcpr[$1]} method seleted: \e[96;5m${methodtmp}\e[0m\n"
  fi
    #Change method MP2 for complete name
  if [ "$methodtmp" = "MP2" ]
  then
     methodtmp="MP2/aug-cc-pVTZ"

  elif [ "$methodtmp" = "MP2/aug-cc-pVTZ" ]
  then
     methodtmp="MP2"
     methodtmplong="MP2/aug-cc-pVTZ"
  else
     methodtmplong=$methodtmp
  fi
  if [ "$1" = 0 ]
  then
     method=$methodtmp
     methodlong=$methodtmplong
  else
     methodmop=$methodtmp
     methodmoplong=$methodtmplong
  fi

}


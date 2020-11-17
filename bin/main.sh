#!/bin/bash

clear

source ./bin/config/config.sh
source ./bin/menu/menu.sh
source ./bin/menu/menuopts.sh
source ./bin/prgmscr/gauss.sh
source ./bin/prgmscr/mopac.sh
source ./bin/fnct/state.sh
source ./bin/fnct/chkst.sh
source ./bin/fnct/sev.sh
source ./bin/fnct/ask.sh
source ./bin/fnct/other.sh
source ./bin/fnct/checkfld.sh

#Programs
calcpr=("GAUSSIAN" "MOPAC")

#Initialize options gaussian
opt_geom="true"
freq="true"

#Number of columns in menu
COLUMNS=0

#If there's a positional parameter, use it as molecules, if not, ask molec activated
if ! [ "$1" == "" ]
then
   molec=$1
fi

#If there's a second positional parameter, use it as method, if not, ask for method activated
if ! [ "$2" == "" ]
then
   method=$2
   if [ $method = "MP2" ]
   then
      methodlong="MP2/aug-cc-pVTZ"
   fi
fi

#If there's a second positional parameter, use it as method, if not, ask for method activated
if ! [ "$3" == "" ]
then
   methodmop=$3
   methodmoplong=$3
fi

trap interrupt_c INT

#*********************************
#*********************************
#           SCRIPT START         *
#*********************************
#*********************************

state=0
while [ 0 ]
do
   dummy_del
   clear
   gaussian_opts
   call_menuopt
   menugm $state $colormenuv 
   select opciones in "${opt_array[@]}"
   do
    case $opciones in
      
      #Main menu options
      "GAUSSIAN")
        state=1
        clear
        break 
      ;;

      "MOPAC")
        state=2
        clear
        break
      ;;

      "Gaussian ALL"|"Input gaussian")
        if ! [ $molec = "ALL" ]
        then
          gaussian_input
        else
          allmol_gauss 1
        fi
      ;;&
        "Gaussian ALL" | "Input sbatch gaussian")
        if ! [ $molec = "ALL" ]
        then
          gaussian_sbatch
        else
          allmol_gauss 2
        fi
      ;;&
      "Gaussian ALL" | "Launch gaussian")
        if ! [ $molec = "ALL" ]
        then
          gaussian_launch
        else
          allmol_gauss 3
        fi
      ;;&
      "Gaussian ALL" | "Input gaussian" | "Input sbatch gaussian" | "Launch gaussian")
          completecho
      ;;
              
      "MOPAC ALL" | "Input MOPAC")
        if ! [ $molec = "ALL" ]
        then
          mopac_input
        else
          allmol_mop 1
        fi
      ;;&
      "MOPAC ALL" | "Launch MOPAC")
        if ! [ $molec = "ALL" ]
        then
          mopac_launch
        else
          allmol_mop 2
        fi
      ;;&
      "MOPAC ALL" | "Input MOPAC" | "Launch MOPAC")
          completecho
      ;;
      "MOPAC for remaining molecules")
          allnotdonemol_mop 0
          completecho
      ;;
      
      "Check results MOPAC")
        state=4
	clear
        break
      ;;
      "Check status")
          check_status
      ;;
      "Change molecule" | "Change ALL")
         askingmol 0
      ;;&

      "Change method GAUSSIAN" | "Change ALL")
         askingmethod 0
      ;;&

      "Change method MOPAC" | "Change ALL")
         askingmethod 1
      ;;&

      "Change molecule" | "Change method GAUSSIAN" | "Change method MOPAC" | "Change ALL")
	clear
        menuslb=$menustmp
        break 
      ;;

      "Change options GAUSSIAN")
        state=3
	clear
        menuslb=7
        break
      ;;
      
      "Geometry optimization")
        if [ $opt_geom = "false" ]
        then
           opt_geom="true"
        else
           opt_geom="false"
        fi        
        clear
        break
      ;;
      "Frequencies")
        if [ $freq = "false" ]
        then
           freq="true"
        else
           freq="false"
        fi        
        clear
        break
      ;;
      "By method")
         chk_resmop_method
      ;;
      "By molecule")
         chk_resmop_mol
      ;;       
      
      "EXIT")
        clear
      	dummy_del
        exit
      ;;

      "BACK")
        if [ $state -eq 3 ]
        then
          state=1
        menuslb=1
        elif [ $state -eq 4 ]
        then
          state=2
        menuslb=2
        else
          state=0
        menuslb=0
        fi
        clear
        break  
      ;;
      *)
        inperr
      ;;   
    esac
   done
 
done


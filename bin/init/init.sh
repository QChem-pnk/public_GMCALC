#!/bin/bash

first_time=`tail -n 1 ${DIR}/bin/init/init.sh`

launch_comm=`set | sed -n '/^launch_sbatch ()/,/^}/p' | tail -n 2 | head -n 1`

function show_wd_lc {
   echo -e "\n\e[36mWorking directories:\e[0m\n"
   echo -e "\tWorking directory (main): \t $work_fld"
   echo -e "\tGaussview files (.gjf):   \t $gjf_fld"
   echo -e "\tGaussian inp files (.com):\t $com_fld"
   echo -e "\tGaussian out files (.log):\t $log_fld"
   echo -e "\tMOPAC files:              \t $mopac_fld"
   echo -e "\n\n\e[36mLaunch command:\e[0m\n\n\t $launch_comm\n"
   echo -e "Account: ${account}\t Partition: ${partition}\n"
}

if ! [ "$first_time" = "#DONE" ]
then
   while :; do
   clear
   echo -e "Seems like this is your first time. \nThese are the \e[36minitial configuration\e[0m.\n"
   show_wd_lc
   echo -e "\nDo you want to continue? [y/n]\n"
   if ! $lqta; then
       echo -ne "\e[97m(If you're from lqta, introduce 'lqta')\e[0m\n"
   fi
   read input
    case $input in
     [yY])
        echo "#DONE" >> ${DIR}/bin/init/init.sh
        echo -e "\n\n\e[5;32mInitial configuration done.\e[0m\n"
        sleep 2
        break
     ;;
     [nN])
        echo -e "\n\nPlease, edit \e[36mconfig.sh\e[0m at your convenience.\n"
        exit
     ;;
     lqta)
       cp ${DIR}/bin/initi/.lqta_config.sh ${DIR}/config.sh
       source ${DIR}/config.sh
       echo -e "LQTA configuration done. These are the variables:"
       show_wd_lc
       echo -e "Press a key to continue."
       read -n 1 input
       break
     ;;
     *)
        echo -e "\n\n\e[5;31mNot a valid option.\e[0m\n"
        sleep 2
     ;;
    esac
   done
fi


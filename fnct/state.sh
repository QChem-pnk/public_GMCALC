#!/bin/bash

#Function to check what mólecules are completed
function check_status {

   printf " %11s__%3s__%3s__%3s__%3s__%3s__%3s_ \n" "___________" "___" "___" "___" "___" "___" "___"
   printf "|    \\MET\e[4mHOD\e[0m||%3s||%3s||%3s||%3s||%3s||%3s||\n"
   printf "|     \\ |\e[4mG|M\e[0m||%3s||%3s||%3s||%3s||%3s||%3s||\n" ${shmetodos[@]}
   printf "|\e[4m%11s\e[0m||%3s||%3s||%3s||%3s||%3s||%3s||\n" "MOLEC \    " "___" "___" "___" "___" "___" "___"

shmetodos=("MP2" "AM1" "PM3" "PM6" "PM7" "RM1")
          buscagaus="Normal termination of Gaussian"
          buscamopac="JOB ENDED NORMALLY"
          dummy_del
          get_all_molecules 0
          moleculas=`sort -u dummytxt`

          for ci in ${moleculas[*]}
          do
              str="|\e[4m%-11s\e[0m||"
             # for cj in "MP2" "AM1" "PM3" "PM6" "PM7" "RM1"
              for cj in ${shmetodos[*]}
              do
                 if [ -f ${log_fld}/${ci}_${cj}.log ]
                 then
                     tail -n 1 ${log_fld}/${ci}_${cj}.log | grep "${buscagaus}" > /dev/null 2>&1 && str="${str}\e[42m%1s\e[0m|" || str="${str}\e[41m%1s\e[0m|"
                 else
                     str="${str}%1s|"
                 fi
                 if [ -f ${mopac_fld}/${cj}/${ci}_${cj}.out ]
                 then
                     grep "${buscamopac}" ${mopac_fld}/${cj}/${ci}_${cj}.out > /dev/null 2>&1 && str="${str}\e[42m%1s\e[0m||" || str="${str}\e[41m%1s\e[0m||"
                 else
                     str="${str}%1s||"
                 fi
              done
              printf "${str}\n" "$ci" "_" "_" "_" "_" "_" "_" "_" "_" "_" "_" "_" "_"
          done
        echo -e "\nPress a key to continue."
        read input
        break
}


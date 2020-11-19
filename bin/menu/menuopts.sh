#!/bin/bash

#Options
salidaex="EXIT"
gaussianopt="GAUSSIAN"
mopacopt="MOPAC"
volver="BACK"
cambio_t=("Check status" "Change molecule" "Change method GAUSSIAN"  "Change method MOPAC" "Change ALL")
gaussian_sub=("Gaussian ALL" "Input gaussian" "Input sbatch gaussian" "Launch gaussian" "Change options GAUSSIAN")
mopac_sub=("MOPAC ALL" "Input MOPAC" "Launch MOPAC" "MOPAC for remaining molecules" "Check results MOPAC")
gauss_opt=("${options_gauss_menu[@]}")
gauss_opt+=("Deactivate options")

mopac_opt=("By method" "By molecule")

validOptions=""
for key in ${!options_gauss_menu[@]}
do
        validOptions="$validOptions${options_gauss_menu[$key]}|"
done
validOptions="${validOptions}Deactivate options"

#Function to call the menu
function call_menuopt {
    opt_array=()
    opt_array+=("$salidaex")
    if ! [ -z "$molec" ]
    then
       case $state in
         0)
           if [ ! -z $method ]
           then
             opt_array+=("$gaussianopt")
             if [ ! -z "$methodmop" ]
             then
                 opt_array+=("$mopacopt")
             fi
             colormenuv=0
             menuslb=0
            else
             colormenuv=3
             menuslb=3
            fi

         ;;
         1)
           menuslb=1
           opt_array+=("$volver")
           if [ ! -z "$method" ]
           then
             opt_array+=("${gaussian_sub[@]}")
             colormenuv=1
            else
             colormenuv=3
          fi
         ;;
         2)
           menuslb=2
           opt_array+=("$volver")
           if [ ! -z "$method" ]
           then
             if [ ! -z "$methodmop" ]
             then
               opt_array+=("${mopac_sub[@]}")
            fi
             colormenuv=2
            else
             colormenuv=3
           fi
         ;;
         3)
           menuslb=7
           opt_array+=("$volver")
           opt_array+=("${gauss_opt[@]}")
           colormenuv=1
         ;;
         4)
           menuslb=6
           opt_array+=("$volver")
           opt_array+=("${mopac_opt[@]}")
           colormenuv=2
         ;;
       esac
    else
       colormenuv=3
       menuslb=3
    fi
      opt_array+=("${cambio_t[@]}")
}


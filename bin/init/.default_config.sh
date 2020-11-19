#!/bin/bash

#Configuration file for gmcalc (to do)

work_fld=${DIR}/results

#Folders
com_fld=${work_fld}/com
log_fld=${work_fld}/log
mopac_fld=${work_fld}/mopac
gjf_fld=${work_fld}/gjf

#Set methods
metodos=("MP2/aug-cc-pVTZ" "AM1" "PM3" "PM6" "PM7" "RM1")
shmetodos=("MP2" "AM1" "PM3" "PM6" "PM7" "RM1")

#Sbatch variables
account=""
partition=""

#Function to launch to a queue, change to your launch command
function launch_sbatch {
         #Change this line to change launch command 
         sbatch -A ${account} -p ${partition} -n 1 ${1}
}

#array for Gaussian options and its predefault value.
declare -A options_gauss=( [opt]="true" [freq]="true" ["pop=npa"]="false" )
#Array for menu option name for the gaussian option. Please include the name of the option in parentheses before the menu name Ex: [option]="(option) Option description"
declare -A options_gauss_menu=( [opt]="(opt) Geometry optimization" [freq]="(freq) Frequency" ["pop=npa"]="(pop=npa) Population analysis" )

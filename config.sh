#!/bin/bash

#Configuration file for gmcalc (to do)

#Folders
com_fld=${HOME}/lqta/com
log_fld=${HOME}/lqta/log
mopac_fld=${HOME}/lqta/mopac
gjf_fld=${HOME}/lqta/gjf

#Set methods
metodos=("MP2/aug-cc-pVTZ" "AM1" "PM3" "PM6" "PM7" "RM1")
shmetodos=("MP2" "AM1" "PM3" "PM6" "PM7" "RM1")

#Sbatch variables
serv="emtccm_serv"
usersb="emtccm"

#Function to launch to a queue, change to your launch command
function launch_sbatch {
         #Change this line to change launch command 
         sbatch -A ${serv} -p ${usersb} -n 1 ${1}
}


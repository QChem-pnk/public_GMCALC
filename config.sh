#!/bin/bash

#Configuration file for gmcalc (to do)

workingdirectory=${HOME}/lqta/

#Folders
com_fld=${workingdirectory}com
log_fld=${workingdirectory}log
mopac_fld=${workingdirectory}mopac
gjf_fld=${workingdirectory}gjf

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


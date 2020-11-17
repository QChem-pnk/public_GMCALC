#!/bin/bash

#Configuration file for gmcalc (to do)

work_fld=${HOME}/lqta

#Folders
com_fld=${work_fld}/com
log_fld=${work_fld}/log
mopac_fld=${work_fld}/mopac
gjf_fld=${work_fld}/gjf

#Set methods
metodos=("MP2/aug-cc-pVTZ" "AM1" "PM3" "PM6" "PM7" "RM1")
shmetodos=("MP2" "AM1" "PM3" "PM6" "PM7" "RM1")

#Sbatch variables
account="emtccm_serv"
partition="emtccm"

#Function to launch to a queue, change to your launch command
function launch_sbatch {
         #Change this line to change launch command 
         sbatch -A ${account} -p ${partition} -n 1 ${1}
}


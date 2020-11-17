#!/bin/bash



#Check if folders exist
for i in $work_fld $com_fld $com_fld $log_fld $gjf_fld
do
  chkfld $i
done

#Copy .gjf files to gaussview folder
if [ -f $HOME/*.gjf ]
then
        cp *.gjf $gjf_fld 2>/dev/null
fi


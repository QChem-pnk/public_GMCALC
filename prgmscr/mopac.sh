#!/bin/bash

#*********************************
#              MOPAC             *
#*********************************

#Function to generato mopac input
function mopac_input {
                  #Script to get the last geometry from a g09 calculation a write it in
                  filemop=${mopac_fld}/${methodmop}
                  chkfld $filemop
                  #mopac input format

                  file=${log_fld}/${molec}_${method}.log
                  output=${mopac_fld}/${methodmop}/${molec}_${methodmop}.mop

                  #Number of atoms
                  nat=`grep -m 1 'NAtoms=' $file | awk '{print $2}'`
                  #Line of last Standard orientation +4 (Donde empiezan las coordenadas
                  line=`awk '/Standard orientation/ {line=NR} END{print line}' $file`

                  echo CHARGE=0 ${methodmop} PRECISE XYZ > ${output}
                  echo Fragmento: ${molec}.log >> ${output}
                  echo Parto de la geometría optimizada con $method >> ${output}

                  #Imprime las coordenadas en formato de mopac
                  awk '{if (NR > '$line'+4 && NR <= '$line'+4+'$nat') printf "%-4s %12.6f %2s %12.6f %2s %12.6f %2s \n", $2, $4, 1, $5, 1, $6, 1}' $file >> ${output}

                  echo >> ${output}
                  echo FORCE OLDGEO CHARGE=0 ${methodmop} >> ${output}
                  usedmolec="\e[94m$molec\e[0m"
                  last_thing="\e[31mMOPAC\e[0m input generated for molecule $usedmolec"
                  echo -e $last_thing
    }

#Function to launch mopac
function mopac_launch {
                  output=launchmop_${molec}_${methodmop}.sh
                  echo -e "#!/bin/bash\n\n#SBATCH --ntasks=1\n#SBATCH --account=emtccm_serv\n#SBATCH --partition=emtccm\n#SBATCH --job-name=test\n#SBATCH --time=3:00:00\n\nmodule load mopac/2016\n#run the job\n" > ${output}
                  #cp launchmop.sh launchmop_${1}_${2}.sh
                  echo "MOPAC2016.exe ${mopac_fld}/${methodmop}/${molec}_${methodmop}.mop" >> ${output}
                  launch_sbatch ${output}
                  rm ${output}
                  usedmolec="\e[94m$molec\e[0m"
                  last_thing="\e[31mMOPAC\e[0m running for molecule $usedmolec"
                  echo -e $last_thing
}



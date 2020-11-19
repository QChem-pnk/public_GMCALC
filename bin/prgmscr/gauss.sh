#!/bin/bash

#*********************************
#            GAUSSIAN            *
#*********************************

#Function input de gaussian
function gaussian_input {
                 if [ -f ${gjf_fld}/${molec}.gjf ]
                 then
                    output=${com_fld}/${molec}_${method}.com
                    echo -e "%chk=${molec}.chk\n#p ${methodlong} $options_gaus\n\nOptimizing geometry of Cl at ${methodlong}\n" > ${output}
                    awk 'NR >= 6' ${gjf_fld}/${molec}.gjf | sed -e "s/\r//g" >> ${output}
                    blank=`tail -c 1 $output`
                    if [ -z "$blank" ]
                    then
                        echo "" >> ${output}
                    fi
                    usedmolec="\e[94m$molec\e[0m"
                    last_thing="\e[34mGAUSSIAN\e[0m input generated for molecule $usedmolec"
                    echo -e $last_thing
                 else
                  echo -e "\nNo valid .gjp input file to create Gaussian input.\n"
                 fi
}

#Function to generate gaussian sbatch
function gaussian_sbatch {
                  output=./launchgaussian_${molec}_${method}.bash
                  echo -e "#!/bin/bash\n\n" > ${output}
                  # Load gaussian module
                  echo -e "module load gaussian/gaussian\n\n" >> ${output}

                  #Creating working directory
                  echo "mkdir /scratch/$USER/$molec" >> ${output}
                  echo -e "cd /scratch/$USER/$molec\n\n"  >> ${output}

                  # Execution line
                  echo -e "g16 <${com_fld}/${molec}_${method}.com  > ${log_fld}/${molec}_${method}.log\n\n"  >> ${output}

                  # Cleaning
                  echo -e "rm -rf /scratch/$USER/$molec" >> ${output}
                  usedmolec="\e[94m$molec\e[0m"
                  last_thing="\e[34mGAUSSIAN\e[0m sbatch generated for molecule $usedmolec"
                  echo -e $last_thing
}

#Function to launch gaussian
function gaussian_launch {
                  output=./launchgaussian_${molec}_${method}.bash
                  launch_sbatch ${output}
                  rm ${output}
                  usedmolec="\e[94m$molec\e[0m"
                  last_thing="\e[34mGAUSSIAN\e[0m running for molecule $usedmolec"
                  echo -e $last_thing
}

#function to create options for gaussian
function gaussian_opts {
        options_gauss_txt=""
        for key in "${!options_gauss[@]}"; do
              if "${options_gauss[${key}]}"
              then
                  options_gauss_txt="${options_gauss_txt}${key} "
              fi
        done
}

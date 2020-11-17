#!/bin/bash

#Do for all molecules
function allmol_gauss {
       case $1 in
          0 | 1)
             chkf_d ${gjf_fld} gjf 0
             dummy='dummytxt'
             while read molec; do
                gaussian_input
             done < $dummy
          ;;&
          0 | 2 | 3)
             chkf_d ${com_fld} log 0
             dummy='dummytxt'
          ;;&
          0 | 2)
             while read p; do
                gaussian_sbatch
             done < $dummy
          ;;&
          0 | 3)
             while read p; do
                gaussian_launch
             done < $dummy
          ;;
      esac
      rm dummytxt
      molec="ALL"
}

#Hacer todas las moleculas en mopac
function allmol_mop {
          chkf_d ${log_fld} log 0
          dummy='dummytxt'

          while read molec; do
          case $1 in
          0 | 1)
          mopac_input
          ;;&
          0 | 2)
          mopac_launch
          ;;
          esac
          done < $dummy
          rm dummytxt
          molec="ALL"
}

#Hacer las moleculas que no estan ya en mopac
function allnotdonemol_mop {
          chkf_d ${log_fld} log 0
          dummy='dummytxt'
          molectmp=$molec
          while read molec; do
          if ! [ -f ${mopac_fld}/${methodmop}/${molec}_${methodmop}.out ]
          then
            case $1 in
            0 | 1)
            mopac_input
            ;;&
            0 | 2)
            mopac_launch
          ;;
          esac
          fi
          done < $dummy
          rm dummytxt
          molec=$molectmp
}



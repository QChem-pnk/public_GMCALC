#!/bin/bash

bmtop1="__________"
bmtop2="________________"
bmtop3="_________________"

#Function to check results per molecule
function chk_resmop_mol {
        dummy_del
        readarray -t methodres < <(find ${mopac_fld} -mindepth 1 -maxdepth 1 -type d -printf '%P\n')
        fin=`expr ${#methodres[*]} - 1`

        buscaen="TOTAL ENERGY"
        buscazero="ZERO"
        totalenergy=()
        zeroenergy=()

        mollen=`expr ${#molec} + 2`
        if [ `expr ${mollen} % 2` = 0 ]
        then
           unspace=" "
        else
           unspace=""
        fi
        mollen=`expr ${mollen} / 2`
        spaces=""

        for i in `seq $mollen 17`;do
          spaces=" $spaces"
        done

        printf " %10s_%16s_%17s\n" $bmtop1 $bmtop2 $bmtop3
        printf "|%10s %16s %17s|\n"
        printf "|${spaces}\e[0m\e[32;1m%s${spaces}\e[0m|\n" "MOLECULE:${unspace} $molec"
        printf "|%10s_%16s_%17s|\n" $bmtop1 $bmtop2 $bmtop3
        printf "|%10s|%16s|%17s|\n"
        printf "|  \e[34;1m%-6s\e[0m  |  \e[33;1m%-12s\e[0m  |   \e[36;1m%-11s   \e[0m|\n" "METHOD" "TOTAL ENERGY" "ZERO POINT"
        printf "|%10s|%16s|%17s|\n" $bmtop1 $bmtop2 $bmtop3
        printf "|%10s|%16s|%17s|\n"
        i=0
        for i in `seq 0 $fin`
        do
           file=${mopac_fld}/${methodres[$i]}/${molec}_${methodres[$i]}.out
              totalenergy[$i]=$(grep "${buscaen}" ${file} > /dev/null 2>&1 && grep "${buscaen}" ${file} | awk '{printf $4}' )
              zeroenergy[$i]=$(grep "${buscazero}" ${file} > /dev/null 2>&1 && grep "${buscazero}" ${file} | awk '{printf $4}' | cut -d ' ' -f 1)
           altcolor "$i"
           if [ -f $file ]
           then
             if ! [ "${zeroenergy[$i]}" = "" ]
             then
                printf "| ${bblue}%-8s \e[0m| ${bpurple}%14s\e[0m | ${bcyan}%15s \e[0m|\n" "${methodres[$i]}" "${totalenergy[$i]} EV" "${zeroenergy[$i]} KCAL/MOL"
             else
                printf "| ${bblue}%-8s \e[0m| ${bpurple}%14s\e[0m |    ${bred}%12s \e[0m|\n" "${methodres[$i]}" "${totalenergy[$i]} EV" "NO DATA"            
             fi
           else
             printf "| ${bblue}%-8s \e[0m|   ${bred}%12s\e[0m |    ${bred}%12s \e[0m|\n" "${methodres[$i]}" "NO DATA" "NO DATA"
           fi
           if ! [ $i = $fin ]
           then
              printf "|%10s|%15s|%16s|\n" "----------" "----------------" "-----------------"
           fi
        done
        printf "|%10s|%16s|%17s|\n" $bmtop1 $bmtop2 $bmtop3
        echo -e "\nPress a key to continue."
        read input
        dummy_del
        break

}
#Function to check results per method
function chk_resmop_method {
        dummy_del
        rslt_fld=${mopac_fld}/${methodmop}
        file=${rslt_fld}/*.out
        chkf_d ${rslt_fld} out 0
        moleculas=`sort -u dummytxt`
        fin=`wc -l dummytxt | awk '{printf $1}'`
        buscaen="TOTAL ENERGY"
        buscazero="ZERO"

        totalenergy=()
        zeroenergy=()

        printf " %10s_%16s_%17s\n" $bmtop1 $bmtop2 $bmtop3
        printf "|%10s %16s %17s|\n"
        printf "|                 \e[0m\e[32;1m%-12s                 \e[0m|\n" "METHOD: $methodmop"
        printf "|%10s_%16s_%17s|\n" $bmtop1 $bmtop2 $bmtop3
        printf "|%10s|%16s|%17s|\n"
        printf "| \e[34;1m%-8s\e[0m |  \e[33;1m%-12s\e[0m  |   \e[36;1m%-11s   \e[0m|\n" "MOLECULE" "TOTAL ENERGY" "ZERO POINT"
        printf "|%10s|%16s|%17s|\n" $bmtop1 $bmtop2 $bmtop3
        printf "|%10s|%16s|%17s|\n"
        i=0
        fin=`expr $fin - 1`
        for moleci in $moleculas
        do
           file=${rslt_fld}/${moleci}_${methodmop}.out
           totalenergy[$i]=$(grep "${buscaen}" ${file} > /dev/null 2>&1 && grep "${buscaen}" ${file} | awk '{printf $4}' )
           zeroenergy[$i]=$(grep "${buscazero}" ${file} > /dev/null 2>&1 && grep "${buscazero}" ${file} | awk '{printf $4}' | cut -d ' ' -f 1)
           altcolor "$i"
           if [ -f $file ]
           then
             if ! [ "${zeroenergy[$i]}" = "" ]
             then
                printf "| ${bblue}%-8s \e[0m| ${bpurple}%14s\e[0m | ${bcyan}%15s \e[0m|\n" "$moleci" "${totalenergy[$i]} EV" "${zeroenergy[$i]} KCAL/MOL"
             else
                printf "| ${bblue}%-8s \e[0m| ${bpurple}%14s\e[0m |    ${bred}%12s \e[0m|\n" "$moleci" "${totalenergy[$i]} EV" "NO DATA"
             fi
           else
                printf "| ${bblue}%-8s \e[0m|   ${bred}%12s\e[0m |    ${bred}%12s \e[0m|\n" "$moleci" "NO DATA" "NO DATA"
           fi
           if ! [ $i = $fin ]
           then
              printf "|%10s|%15s|%16s|\n" "----------" "----------------" "-----------------"
           fi
           i=`expr $i + 1`
        done
        printf "|%10s|%16s|%17s|\n" $bmtop1 $bmtop2 $bmtop3
        echo -e "\nPress a key to continue."
        read input
        dummy_del
        break
}


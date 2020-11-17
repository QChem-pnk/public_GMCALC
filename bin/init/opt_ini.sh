#!/bin/bash

#Initialization if --init is introduced
if [ $1 = "--init" -o $1 = "--reset" -o $1 = "--lqta" ]
then
   first_time=`tail -n 1 ${DIR}/bin/init/init.sh`
   if [ "$first_time" = "#DONE" ]
   then
      sed -i '' -e '$ d' ${DIR}/bin/init/init.sh
   fi
   if [ $1 = "--reset" ]
   then
      cp ${DIR}/bin/init/.default_config.sh ${DIR}/config.sh
   fi
   if [ $1 = "--lqta" ]
   then
      cp ${DIR}/bin/init/.lqta_config.sh ${DIR}/config.sh
      lqta=true
   fi
   shift
fi


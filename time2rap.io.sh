#!/bin/bash
if [ -z $1 ]
then
	echo "Test de l'acces a https://www.time2rap.cc/"
	ping -c1 www.time2rap.cc && test=1 || test=0 && tput reset
	echo "Time2rap Downloads Version 1.0.4"
	if [ "$test" = 1 ]
	then
	  echo "time2rap.cc est en ligne"
	else
	  echo "time2rap.cc est hors ligne"
	  exit
	fi
fi
cd include/
./search.time2rap.io.sh
exit
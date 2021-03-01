#!/bin/bash
if [ -z $1 ]
then
	echo "Test de l'acces a https://www.time2rap.io/"
	ping -c1 www.time2rap.io && test=1 || test=0 && tput reset
	echo "Time2rap Downloads Version 1.0.3"
	if [ "$test" = 1 ]
	then
	  echo "time2rap.io est en ligne"
	else
	  echo "time2rap.io est hors ligne"
	  exit
	fi
fi
cd include/
./search.time2rap.io.sh
exit
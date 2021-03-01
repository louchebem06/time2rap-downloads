#!/bin/bash
read choix
if [ -z $choix ]; then
	tput reset
	echo -e "Une erreur de saisie a était detecter"
	./search.time2rap.io.sh
	exit
elif [ $choix == "exit" ]; then
	tput reset
	echo "Fermeture du programme"
	exit
elif [ $choix == "new" ]; then
	tput reset
	cd ..
	./time2rap.io.sh "no"
	exit
fi
if [[ "$choix" =~ ^[-+]?[0-9]+$ ]]; then
	if [ $choix -gt $2 -o $choix -lt 1 ]; then
		tput reset
		echo -e "Une erreur de saisie a était detecter"
		./search.time2rap.io.sh
		exit
	fi
else
	tput reset
	echo -e "Une erreur de saisie a était detecter"
	./search.time2rap.io.sh
	exit
fi
./downloads.time2rap.io.sh "$1" "$choix"
exit
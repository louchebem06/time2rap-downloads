#!/bin/bash
echo -e "Recherche a effectuer sur le site\nexit: Sortir du programme"
read search
if [ -z $search]; then
	tput reset
	echo "Pas de parametre"
	./search.time2rap.io.sh
	exit
elif [ $search == "exit" ]; then
	tput reset
	echo "Fermeture du programme"
	exit
fi
tput reset
echo "Recherche pour \"$search\" en cours"
search=$(echo "$search" | sed 's/ /+/g')
search="https://time2rap.io/?s=$search"
url=$(curl --progress-bar $search | grep 'album-complet.html">$' | cut -c12- | rev | cut -c3- | rev)
if [[ -n $url ]]; then
	nb=$(echo -e "$url" | wc -l)
else
	nb=0
fi
if [ $nb == "0" ]; then
	tput reset
	echo "Pas de resultat"
	cd ..
	./time2rap.io.sh "no"
	exit
else
	tput reset
	echo "Nombre d'album trouver : $nb"
	resultat=$(echo -e "$url" | cut -c25- | rev | cut -c20- | rev | sed 's/-/ /g' | awk '{out++; print out"|"$0}')
	echo -e "$resultat"
	echo -e "\nChoix de l'album de 1 a $nb\nnew: Nouvelle recherche\nexit: Sortir du programme"
	./choix.time2rap.io.sh "$url" "$nb"
	exit
fi
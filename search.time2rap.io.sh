#!/bin/bash
tput reset
echo "Test de l'acces a https://www.time2rap.io/"
ping -c1 www.time2rap.io && test=1 || test=0 && tput reset
echo "Version 1.0.2"
if [ "$test" = 1 ]
then
  echo "time2rap.io est en ligne"
else
  echo "time2rap.io est hors ligne"
  exit
fi
echo "Recherche a effectuer sur le site"
read search
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
if [ $nb -eq 0 ]; then
	tput reset
	echo "Pas de resultat"
else
	tput reset
	echo "Nombre d'album trouver : $nb"
	resultat=$(echo -e "$url" | cut -c25- | rev | cut -c20- | rev | sed 's/-/ /g' | awk '{out++; print out"|"$0}')
	echo -e "$resultat"
	echo -e "\nChoix de l'album"
	read choix
	choix=$choix"p"
	tput reset
	echo "Recuperation des informations"
	website=$(echo -e "$url" | sed -n $choix)
	titre=$(curl --progress-bar $website | grep '<title>' | cut -c8- | rev | cut -c104- | rev | sed "s/&rsquo;/'/g" | sed "s/&#8211;/-/g")
	artiste=$(echo $titre | cut -d "-" -f 1 | rev | cut -c2- | rev)
	album=$(echo $titre | cut -d "-" -f 2 | cut -c2- | rev | cut -c1- | rev)
	if [ -d "$artiste" ]; then
		tput reset
		echo "Dossier de l'artiste trouver"
		cd "$artiste"
	else
		tput reset
		echo "Creation du dossier de l'artiste"
		mkdir "$artiste"
		cd "$artiste"
	fi
	if [ -d "$album" ]; then
		tput reset
		echo "L'album existe deja"
	else
		tput reset
		echo "Creation du dossier de l'album"
		mkdir "$album"
		cd "$album"
		tput reset
		echo "Recherche du lien du player"
		player=$(curl --progress-bar $website | grep '<iframe src' | cut -c22- | rev | cut -c103- | rev)
		tput reset
		echo "Recuperation des liens de telechargement"
		download=$(curl --progress-bar $player | grep 'data-download' | cut -d "\"" -f 8 | awk '{print $0"?view=telecharger"}' | sed 's/ /%20/g')
		tput reset
		echo "Telechargement en cours"
		wget -q --show-progress $download
		tput reset
		echo "Renomage des fichiers"
		find ./ -type f -name "*.mp3?view=telecharger" -exec sh -c 'mv "$(basename "{}")" "$(basename "{}" ?view=telecharger)"' \;
		tput reset
		echo "Artiste 	: $artiste"
		echo "Album		: $album"
		echo "Repertoire des fichiers :"
		pwd
	fi
fi
#!/bin/bash
choix=$2"p"
tput reset
echo "Recuperation des informations"
website=$(echo -e "$1" | sed -n $choix)
titre=$(curl --progress-bar $website | grep '<title>' | cut -c8- | rev | cut -c104- | rev | sed "s/&rsquo;/'/g" | sed "s/&#8211;/-/g")
artiste=$(echo $titre | cut -d "-" -f 1 | rev | cut -c2- | rev)
album=$(echo $titre | cut -d "-" -f 2 | cut -c2- | rev | cut -c1- | rev)
cd ..
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
	cd ../include/
	./search.time2rap.io.sh
	exit
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
	echo -e "\n"
	cd ../../include/
	./search.time2rap.io.sh
	exit
fi
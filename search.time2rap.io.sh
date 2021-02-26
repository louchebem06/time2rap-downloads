tput reset
echo "Version 1.0"
echo "Recherche a effectuer sur le site https://www.time2rap.io/"
read search
tput reset
echo "Recherche pour \"$search\" en cours"
search=$(echo "$search" | sed 's/ /+/g')
search="https://time2rap.io/?s=$search"
url=$(curl -s $search | grep 'album-complet.html">$' | cut -c12- | rev | cut -c3- | rev)
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
	resultat=$(echo -e "$url" | cut -c25- | rev | cut -c20- | rev | sed 's/-/ /g' | awk '{out++; print out") "$0}')
	echo -e "$resultat"
	echo -e "\nChoix de l'album"
	read choix
	choix=$choix"p"
	website=$(echo -e "$url" | sed -n $choix)
	titre=$(curl -s $website | grep '<title>' | cut -c8- | rev | cut -c104- | rev | sed "s/&rsquo;/'/g" | sed "s/&#8211;/-/g")
	artiste=$(echo $titre | cut -d "-" -f 1 | rev | cut -c2- | rev)
	album=$(echo $titre | cut -d "-" -f 2 | cut -c2- | rev | cut -c1- | rev)
	if [ -d "$artiste" ]; then
		tput reset
		echo "Dossier d'artiste trouver"
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
		echo "Scan du site en cours"
		player=$(curl -s $website | grep '<iframe src' | cut -c22- | rev | cut -c103- | rev)
		download=$(curl -s $player | grep 'data-download' | cut -d "\"" -f 8 | awk '{print $0"?view=telecharger"}' | sed 's/ /%20/g')
		tput reset
		echo "Telechargement en cours"
		wget -q $download
		tput reset
		echo "Renomage des fichiers"
		find ./ -type f -name "*.mp3?view=telecharger" -exec sh -c 'mv "$(basename "{}")" "$(basename "{}" ?view=telecharger)"' \;
		tput reset
	fi
fi
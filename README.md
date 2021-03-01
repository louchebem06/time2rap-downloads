# time2rap-downloads
Script qui telecharge les album complet du site time2rap.io sans passer par la case PUB<br>
Pour recuperer le fichier
```shell
git clone https://github.com/louchebem06/time2rap-downloads.git time2rap-downloads
cd time2rap-downloads
chmod -R 755 ./*
```
Lancer le script
```shell
./time2rap.io.sh
```
Les fichier seront telecharger dans le repertoire courant ranger
CTRL+C pour arreter le script<br>
<a href="https://user-images.githubusercontent.com/34492446/109463496-65045380-7a65-11eb-907e-81127c9c6b5f.mp4">Demo Video</a><br>
![alt text](https://github.com/louchebem06/time2rap-downloads/blob/main/img/1.png?raw=true)
![alt text](https://github.com/louchebem06/time2rap-downloads/blob/main/img/2.png?raw=true)
![alt text](https://github.com/louchebem06/time2rap-downloads/blob/main/img/3.png?raw=true)

PROGRAMME ADDITIONNEL
- Bash
- Curl
- Grep
- Sed
- wget

Pour les installer
```shell
sudo apt install bash curl grep sed wget
```

FIX BUG
- Nom des dossiers d'artiste ou d'album

Log UPDATE 1.0.3
- Reboot du script : parametre vide ou mauvais choix
- Nouvelle recherche automatiquement
- Posibiliter de sortir du script

Log UPDATE 1.0.2
- Test si le site time2rap.io et accesible

Log UPDATE 1.0.1
- Progres bar
- Amelioration style tableau de recherche d'album
- Log end downloads

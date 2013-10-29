#!/bin/bash



while [ -z ${sitename} ]; do
	echo "Quel nom ?"
	read sitename
done
base="/www/"$sitename

echo -e "Lien vers le répertoire? [$GREEN$base$RESET]"
read base_usr

if [ ! -z $base_usr ]; then
	base=$base_usr
fi

if [ ! -d $base ]; then
	while [ ! -d $base]; do
		echo $e "$MAGENTA$base n'existe pas$RESET"
		echo "Lien vers le répertoire"
		read $base
	done
fi

root=/
echo -e "répertoire contenant le index.html $ORANGE$base$RESET[$GREEN$root$RESET]"
read root_usr

if [ ! -z $root_usr ]; then
	while [ ! -d $base$root_usr ]; do
		echo -e "$MAGENTA$base$root_usr$RESET n'existe pas"
		read $root_usr
	done
	root=$root_usr
fi

echo -e "Quel port ? [$GREEN:80$RESET]"
read port

if [ -z $port ]; then
	port=80
fi

if [ -f sites-available/$sitename ]; then
	echo "ce fichier existe déjà"
	exit
fi

echo -e "sitename : $GREEN$sitename$RESET"
echo -e "répertoire : $GREEN$base$RESET"
echo -e "app dir : $GREEN$base$root$RESET"
echo -e "port : $GREEN$port$RESET"

cat .create.base | sed "s/\$sitename/$sitename/g" | sed "s/\$site_port/$port/g" | sed "s@\$base@$base@g" | sed "s@\$root@$base$root@g" > sites-available/$sitename

cd sites-enabled
ln -s ../sites-available/$sitename $sitename

ok="\033[1;32m [ok] \033[0m"
warn="\033[1;34m [warn] \033[0m"
echo -e "$ok fichier sites-available/$sitename créé"
echo -e "$ok lien relatif sites-enabled/$sitename créé"



echo -e "$ok Terminé, vous pouvez relancer NGINX"

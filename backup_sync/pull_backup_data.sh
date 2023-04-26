#!/bin/bash
#
# Description
# 1. Ia fisierul exportat de catre buku, de pe sever si il importa
#
# Usage:
# ./pull_backup_data.sh
# Portul si denumirile fisierelor declarate mai jos, trebuie updatate
# 
# Atentie:
# Daca e prima data cand folosesc local aplicatia study-app, trebuie mai intai sa rulez binarul dupa care pot face importul de mysql dump
#
# Assumtions:
# - numele containerului de la aplicatia study-app este study-mysql
# - credentialele containerului mysql de la aplicatia study-app
#
PORT=7131
BUKU_BACKUP_NAME=buku_backup.db
STUDY_BACKUP_NAME=study_backup.sql

# Description:
# Functie care imi arata daca un packet este instalat local
# 
# Return 
# 0 daca nu este instalat
# 1 daca este intalat
# 
# Usage:
# is_installed="$(package_installed neovim)"
# if [[ "$is_installed" == 0 ]]; then
#         echo is not installed
# fi
package_installed() {
	local output="$(dpkg -l "${1}" 2>&1)"
	local search_part='no packages found matching'

	if [[ "$output" == *"$search_part"* ]]; then
			# not installed
			echo 0
	else
			# installed
			echo 1
	fi
}


if [[ -f /tmp/.update.log ]];then
	rm /tmp/.update.log
fi

echo "Checking server time..."
# Iau logul de pe server pentru a compara daca timpul de pe server este mai vechi decat
scp -P $PORT ramonbassecharcan@165.232.117.151:./storage/.update.log /tmp/

# Daca nu exista /tmp/.update.log inseamna ca nu m-am putut conecta la sever si retunt la tot procesul
if [[ ! -f /tmp/.update.log ]];then
	echo "[!] Unable to connect to server. Abort process"
	exit 1
fi

mapfile -t arr < /tmp/.update.log
server_time=${arr[1]} # time cand s-a facut ultimul push la server
server_user=${arr[0]} # userul care a facut ultimul push

mapfile -t larr < $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log
local_time=${larr[1]} # time cand am facut ultima data push de aici
local_user=${larr[0]} # userul local

printf "Server time: %d\nLocal last push: %d\n" $server_time $local_time

# Verific ca versiunea locala sa fie mai veche decat cea de pe server
if [[ $server_time -lt $local_time ]];then
	read -p "[!] Versiunea de pe server e mai veche decat cea locala. Continui? [y]" userResponse 
	if [[ "$userResponse" != 'y' ]];then
		exit 1
	fi
fi


## 1. BUKU
is_installed="$(package_installed buku)"
if [[ "$is_installed" == 0 ]];then
	echo "Buku not installed. Skipping buku update"
else
	echo "Getting buku database..."
	# Daca exista deja fisierul de la server, il sterg sa nu faca overwrite
	if [[ -f /tmp/$BUKU_BACKUP_NAME ]]; then
		rm /tmp/$BUKU_BACKUP_NAME
	fi

	# Copii de la server fisierul exportat de buku
	scp -P $PORT ramonbassecharcan@165.232.117.151:./storage/$BUKU_BACKUP_NAME /tmp/

	# Import fisierul de la server
	buku -i /tmp/$BUKU_BACKUP_NAME 2>/tmp/.buku.update.log

	# Cate am deja adaugate?
	added=$(egrep 'already exists' /tmp/.buku.update.log | wc -l)
	printf "%d bookmarks already found\n" $added

	# Sterg fisierul de la server
	rm /tmp/$BUKU_BACKUP_NAME
fi


## 2. STUDY-APP DATABASE 

# Description:
# Functie care o apelez dupa ce stiu ca este instalat docker
# Pornesc containerul daca exista
# Downladez sql dump de pe sever
# Import sql dump in containerul de docker
#
# Atentie:
# Daca e prima data cand folosesc local aplicatia study-app, trebuie mai intai sa rulez binarul dupa care pot face importul de mysql dump
sync_study_app() {
	found=0

	# Verific daca exista containerul denumit "study-mysql"
	# awk '{print $NF}' printeaza ultimul cuvant din rand
	for l in $(docker container ls -a | awk '{print $NF}')
	do
		if [[ "$l" =~ .*study-mysql.* ]];then
			echo "container found..."
			found=1
		fi
	done

	if [[ $found -eq 1 ]];then 
		echo "Starting container..."
		docker container start study-mysql

		# Astept sa se porneasa complet
		sleep 2

		# Daca exista deja fisierul exportat il sterg
		if [ -f /tmp/$STUDY_BACKUP_NAME ];then
			rm /tmp/$STUDY_BACKUP_NAME
		fi

		# Iau de pe sever exportul de backup
		echo "Getting database dump from server..."
		scp -P $PORT ramonbassecharcan@165.232.117.151:./storage/$STUDY_BACKUP_NAME /tmp/

		# Import sql dump in containerul cu baza de date
		echo "Importing to local container..."
		docker exec -i study-mysql sh -c 'exec mysql -uroot -pstudymqsql mysql' < /tmp/$STUDY_BACKUP_NAME

		# Stopping container
		read -p "Stop study-app container? [y]" userResponse
		if [[ "$userResponse" = 'y' ]];then
			docker container stop study-mysql
		fi
	else
		echo "study-mysql docker container not found. Skipping study-app sync"
	fi
}

is_installed="$(package_installed docker)"
if [[ "$is_installed" == 0 ]];then
	echo "Docker not installed. Skipping study-app database"
else
	echo "[+] docker installed..."
	sync_study_app
fi

## 3. NOTES
scp -P $PORT ramonbassecharcan@165.232.117.151:./storage/notes.tar.gz /tmp/
# TODO Aici trebuie facut cu rsync - nu pare ca inlocuieste fisierele din arhiva existente local
#tar czf /tmp/notes.tar.gz -C ~/Documents/notes/ .

## 4. KEEP
scp -P $PORT ramonbassecharcan@165.232.117.151:./keep.com $HOME/


# 4. Updatez timpul local de pull
time=$(date +%s)
echo $USER > $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log
echo $local_time >> $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log
# Randul 3 arata cand s-a facut ultima data pull
echo $time >> $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log


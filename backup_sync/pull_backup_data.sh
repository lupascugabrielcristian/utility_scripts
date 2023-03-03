#!/bin/bash
#
# Description
# 1. Ia fisierul exportat de catre buku, de pe sever si il importa
#
# Usage:
# ./pull_backup_data.sh
# Portul si denumirile fisierelor declarate mai jos, trebuie updatate
# 
PORT=7131
BUKU_BACKUP_NAME=buku_backup.db
STUDY_BACKUP_NAME=study_backup.sql

## 1. BUKU
echo "Getting buku database"
# Daca exista deja fisierul de la server, il sterg sa nu faca overwrite
if [[ -f /tmp/$BUKU_BACKUP_NAME ]]; then
	rm /tmp/$BUKU_BACKUP_NAME
fi

# Copii de la server fisierul exportat de buku
scp -P $PORT ramonbassecharcan@165.232.117.151:./storage/$BUKU_BACKUP_NAME /tmp/

# Import fisierul de la server
buku -i /tmp/$BUKU_BACKUP_NAME

# Sterg fisierul de la server
rm /tmp/$BUKU_BACKUP_NAME


## 2. STUDY-APP DATABASE 

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

sync_study_app() {
	echo "[+] docker installed..."
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
		scp -P $PORT ramonbassecharcan@165.232.117.151:./storage/$STUDY_BACKUP_NAME /tmp/

		# Import in baza de date
	else
		echo "study-mysql docker container not found. Skipping study-app sync"
	fi
}

is_installed="$(package_installed docker)"
if [[ "$is_installed" == 0 ]];then
	echo "Docker not installed. Skipping study-app database"
else
	sync_study_app
fi




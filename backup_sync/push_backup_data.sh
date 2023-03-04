#!/bin/bash
#
# Description
# 1. Trimit buku bookmarks la serverul de storage.
# 2. Trimit baza de date de la aplicatia study
# Scriptul asta va fi executat de comanda ../bin/sync_backup
# Scriptul asta vine dupa sync_backup_data.sh ca sa nu mai trimit date nefolositoare
# 
# Presupuneri:
# 1. Containerul docker pentru aplicatia study este denumit: study-mysql
# 2. Credentialele containerului docker de la aplicatia study
# 
# Usage:
# ./sync_backup_data.sh
# Portul si denumirile fisierelor de backup, declarate mai jos, trebuie updatate


PORT=7131
BUKU_BACKUP_NAME=buku_backup.db
STUDY_BACKUP_NAME=study_backup.sql

echo "Checking server time..."
# Iau logul de pe server pentru a compara daca timpul de pe server este mai vechi decat
scp -P $PORT ramonbassecharcan@165.232.117.151:./storage/.update.log /tmp/

mapfile -t arr < /tmp/.update.log
server_time=${arr[1]} # time cand s-a facut ultimul push la server
server_user=${arr[0]} # userul care a facut ultimul push

if [[ -f $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log ]];then
	mapfile -t larr < $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log
	local_user=${larr[0]} # Randul 1 este userul local
	local_time=${larr[1]} # Randul 2 contine timpul cand am facut ultima data push de aici
	local_pull=${larr[2]} # Randul 3 contine timpul cand s-a facut pull ultima data
else
	local_user=$USER
	local_time=0
	local_pull=0
fi

# In cazul in care userul local difera de userul de pe sever,
# Sa nu fac push daca nu am facut pull
# Adica timpul de pull sa fie mai mare decat timpul de pe server
if [[ $server_user != $local_user ]];then
	printf "local_pull=%d, server_time=%d\n" $local_pull $server_time
	if [[ $local_pull -lt $server_time ]];then
		read -p "Trebuie facut pull mai intai. Continui? [y]" userResponse

		if [[ "$userResponse" != 'y' ]];then
			exit 1
		fi
	fi
fi

## 1. BUKU
echo "Sending buku database"
# Daca exista deja fisierul exportat il sterg ca sa nu ma intrebe daca ii fac overwrite
if [ -f /tmp/$BUKU_BACKUP_NAME ];then
	rm /tmp/$BUKU_BACKUP_NAME
fi

# Export salvarile curente
buku -e /tmp/$BUKU_BACKUP_NAME

# Trimit la server backup buku
scp -P $PORT /tmp/$BUKU_BACKUP_NAME ramonbassecharcan@165.232.117.151:./storage

## 2. STUDY APP 
# Pornesc containerul 
docker container start study-mysql

# Astept sa se porneasa complet
sleep 2

# Daca exista deja fisierul exportat il sterg
if [ -f /tmp/$STUDY_BACKUP_NAME ];then
	rm /tmp/$STUDY_BACKUP_NAME
fi

# Export baza de date
docker exec study-mysql /usr/bin/mysqldump -u root --password=studymqsql mysql > /tmp/$STUDY_BACKUP_NAME

# Trimit la server backup buku
scp -P $PORT /tmp/$STUDY_BACKUP_NAME ramonbassecharcan@165.232.117.151:./storage

# Opresc containerul numit study-mysql
open_containers=$(docker ps | awk 'NR>1 { print $13}')

for l in $open_containers
do
	# if [[ "$l" == "study-test" ]]; then
	# 	printf "este $l\n"
	# fi

	# Varianta scurta la cea de mai sus
	[ "$l" == "study-mysql" ] && docker container stop study-mysql
done


# 3. Updatez timpul local de push pentru verificare ultirioara cu serverul
time=$(date +%s)
echo $USER > $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log
echo $time >> $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log

# Trimit pe server .update.log
scp -P $PORT $LOCATION_OF_UTILITIES_FOLDER/backup_sync/.update.log ramonbassecharcan@165.232.117.151:./storage

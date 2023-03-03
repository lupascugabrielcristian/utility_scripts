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
echo $USER > $LOCATION_OF_UTILITIES_FOLDER/last_push.log
echo $time >> $LOCATION_OF_UTILITIES_FOLDER/last_push.log

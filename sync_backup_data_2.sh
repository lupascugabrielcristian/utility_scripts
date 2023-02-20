#!/bin/bash
#
# Description
# Trimit buku bookmarks la serverul de storage.
# Scriptul asta va fi executat de comanda din folderul ../bin/sync_backup
# 
# Usage:
# ./sync_backup_data.sh

echo "Sending buku database"
# Daca exista deja fisierul exportat il sterg ca sa nu ma intrebe daca ii fac overwrite
if [ -f /tmp/buku_backup.db ];then
	rm /tmp/buku_backup.db
fi

# Export salvarile curente
buku -e /tmp/buku_backup.db

# Trimit la server
scp /tmp/buku_backup.db ramonbassecharcan@165.232.117.151:./storage

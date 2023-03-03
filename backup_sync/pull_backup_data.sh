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

## 1. BUKU
echo "Getting buku database"
# Daca exista deja fisierul de la server, il sterg sa nu faca overwrite
if [[ -f /tmp/$BUKU_BACKUP_NAME ]]; then
	rm /tmp/$BUKU_BACKUP_NAME
fi


scp ....
Trebuie sa las posibilitatea sa ma loghez cu parola cu user non-root

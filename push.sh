#!/bin/bash
read -p "Server IP? " server_ip
read -p "Server port? " server_port
read -p "Home folder? " home_folder
buku -e ~/Documents/buku_backup.db
./package.py $home_folder
scp -P $server_port 2020-*.zip root@$server_ip:saved_data/.
rm 2020-*.zip
rm ~/Documents/buku_backup.db
~                              

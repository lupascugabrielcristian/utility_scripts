#!/bin/bash
read -p server_ip
scp  -P 8522 root@$server_ip:/root/saved_data/2020-*.zip .
ls | grep 2020 | grep -ne .zip

# get user input, 
read -p "Choose file? " number
chosen_file="$(ls | grep 2020 | grep -e .zip | awk NR==$number)"
cp $chosen_file ~/.

# delete zip files not used
rm 2020-*.zip

# unzip chosen file
unzip ~/2020-*.zip -d ~/data_from_backup
pushd ~/data_from_backup/home/*
cp -R vimwiki ~/vimwiki
popd

pushd ~/data_from_backup/home/*/Documents
buku -i buku_backup.db
cp keep.com ~/keep.com # merge asta
cp -R tools ~/tools/
cp -R research ~/research/
popd

# Clean files
rm -rf ~/data_from_backup/
rm ~/2020-*.zip

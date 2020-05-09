read -p "[?] Home folder? " home_folder
read -p "[?] Push(h)/Pull(l)? " operation

if [ "$operation" = 'h' -o "$operation" = 'push' -o "$operation" = 'Push' ]; then
        printf "[+] Pushing to backup server\n"
        printf "[+] Sending keep file\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                $home_folder/keep.com \
                root@104.248.252.160:./sync_folder  "$@" > /dev/null


        printf "[+] Sending vimwiki\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                $home_folder/vimwiki/ \
                --filter='merge ./sync-filter.txt' \
                root@104.248.252.160:./sync_folder/vimwiki  "$@" > /dev/null 


        printf "[+] Sending tools folder\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                $home_folder/Documents/tools/ \
                --filter='merge ./sync-filter.txt' \
                root@104.248.252.160:./sync_folder/tools  "$@" > /dev/null 


        printf "[+] Sending research folder\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                $home_folder/Documents/research/ \
                --filter='merge ./sync-filter.txt' \
                root@104.248.252.160:./sync_folder/research  "$@" > /dev/null 

		buku -e $home_folder/buku_backup.db
        printf "[+] Sending buku \n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                $home_folder/buku_backup.db \
                root@104.248.252.160:./sync_folder  "$@" > /dev/null
		rm $home_folder/buku_backup.db
fi

if [ "$operation" = 'l' -o "$operation" = 'pull' -o "$operation" = 'Pull' ]; then
		printf "[+] Pulling from backup server\n"
        printf "[+] Getting keep file\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                root@104.248.252.160:./sync_folder/keep.com  $home_folder/. "$@" > /dev/null
 


        printf "[+] Pulling vimwiki\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                root@104.248.252.160:./sync_folder/vimwiki/ $home_folder/vimwiki  "$@" > /dev/null 


        printf "[+] Pulling tools folder\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                root@104.248.252.160:./sync_folder/tools/ $home_folder/Documents/tools "$@" > /dev/null 


        printf "[+] Pulling research folder\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                root@104.248.252.160:./sync_folder/research/ $home_folder/Documents/research "$@" > /dev/null 
                

        printf "[+] Getting buku file\n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                root@104.248.252.160:./sync_folder/buku_backup.db $home_folder/. "$@" > /dev/null 
        buku -i $home_folder/buku_backup.db
        rm $home_folder/buku_backup.db "$@" > /dev/null 
fi

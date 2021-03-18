#
#
# In cazul PUSH:
# iau fisierul de pe server denumit last_push.log si il salvez local in [home folder]/last_server_sync.log
# ma uit in fisierul local last_push.log si memorez userul si timpul ultimului push
# daca continui cu operatia de push, trimit pe server noul timp si [home folder] introdus de user
#
#
# In cazul PULL:
# pun in last_push.log local timpul 0
#
#
# In cazul WHO:
# printez continutul fisierului local last_push.log
#

read -p "[?] Push(h)/Pull(l)/Who(w)? " operation

if [ "$operation" = 'h' -o "$operation" = 'push' -o "$operation" = 'Push' ]; then

		read -p "[?] Home folder? " home_folder

		# Iau fisierul de pe server pentru a vedea cand si de catre cine s-a facut ultimul push
        rsync -rzv -e 'ssh -p 8522' --progress \
                root@104.248.252.160:./sync_folder/last_push.log  $home_folder/last_server_sync.log "$@" > /dev/null

		mapfile -t array < $home_folder/last_server_sync.log
		server_time=${array[1]} # memorez cand s-a inregistrat pe server ultimul push
		server_user=${array[0]} # memorez userul care a facut push ultima data pe server

		# Ma uit in fisierul local last_push.log sa vad cand am facut push ultima data
		mapfile -t array < last_push.log
		lpush_time=${array[1]} # memorez cand s-a facut push ultima data de pe calculatorul asta

		if [ $server_time -eq $lpush_time ]; then
			read "[+] Timpul gasit pe server este acelasi cu cel la care s-a facut push de aici. Pot face push"
		elif [ $lpush_time -eq 0 ]; then
			read -p "[?] Doar ce am facut pull. Continui"
		else
			echo $server_time ..server time
			echo $server_user ..server user
			echo $lpush_time ..local push time
			read "[X] Timpul gasit pe server difera de cel la care s-a facut push de pe calculatorul asta. Trebuie facut pull mai intai"
		fi


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


		# Updatez timpul local de push pentru verificare ultirioara cu serverul
		time=$(date +%s)
		echo $home_folder > last_push.log
		echo $time >> last_push.log

        printf "[+] Sending last_push.log file \n"
        rsync -rzv -e 'ssh -p 8522' --progress \
                last_push.log \
                root@104.248.252.160:./sync_folder  "$@" > /dev/null
fi

if [ "$operation" = 'l' -o "$operation" = 'pull' -o "$operation" = 'Pull' ]; then

		read -p "[?] Home folder? " home_folder

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

		# Fac tipul local 0. Asa voi sti ca am facut pull
		echo $home_folder > last_push.log
		echo 0 >> last_push.log
fi

if [ "$operation" = 'w' -o "$operation" = 'who' -o "$operation" = 'Who' ]; then
	echo "Acesta este continutul fisierului last_push.log. Arata cand s-a facut ultimul push de aici. Daca timpul este 0 inseamna ca am facut pull\n"
	cat last_push.log
fi

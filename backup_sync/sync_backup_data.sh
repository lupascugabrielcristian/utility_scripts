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

PORT=7131
IP=165.232.117.151
read -p "[?] Push(h)/Pull(l)/Who(w)? " operation

# PUSH
if [ "$operation" = 'h' -o "$operation" = 'push' -o "$operation" = 'Push' ]; then

		read -p "[?] Home folder? " home_folder

		# Iau fisierul de pe server pentru a vedea cand si de catre cine s-a facut ultimul push
        rsync -rzv -e 'ssh -p $PORT' --progress \
                root@$IP:./sync_folder/last_push.log  $home_folder/last_server_sync.log "$@" > /dev/null

		mapfile -t array < $home_folder/last_server_sync.log
		server_time=${array[1]} # memorez cand s-a inregistrat pe server ultimul push
		server_user=${array[0]} # memorez userul care a facut push ultima data pe server

		# Ma uit in fisierul local last_push.log sa vad cand am facut push ultima data
		mapfile -t array < last_push.log
		lpush_time=${array[1]} # memorez cand s-a facut push ultima data de pe calculatorul asta

		if [ $server_time -eq $lpush_time ]; then
			read -p "[+] Timpul gasit pe server este acelasi cu cel la care s-a facut push de aici. Pot face push"
		elif [ $lpush_time -eq 0 ]; then
			read -p "[?] Doar ce am facut pull. Continui"
		else
			echo $server_time ..server time
			echo $server_user ..server user
			echo $lpush_time ..local push time
			read -p "[X] Timpul gasit pe server difera de cel la care s-a facut push de pe calculatorul asta. Trebuie facut pull mai intai"
		fi


        printf "[+] Pushing to backup server\n"
        printf "[+] Sending keep file\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                $home_folder/keep.com \
                root@$IP:./sync_folder  "$@" > /dev/null


        printf "[+] Sending vimwiki\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                $home_folder/vimwiki/ \
                --filter='merge ./sync-filter.txt' \
                root@$IP:./sync_folder/vimwiki  "$@" > /dev/null 


        printf "[+] Sending tools folder\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                $home_folder/Documents/tools/ \
                --filter='merge ./sync-filter.txt' \
                root@$IP:./sync_folder/tools  "$@" > /dev/null 

        printf "[+] Sending notes folder\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                $home_folder/Documents/notes/ \
                --filter='merge ./sync-filter.txt' \
                root@$IP:./sync_folder/notes  "$@" > /dev/null 


        printf "[+] Sending research folder\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                $home_folder/Documents/research/ \
                --filter='merge ./sync-filter.txt' \
                root@$IP:./sync_folder/research  "$@" > /dev/null 

		buku -e $home_folder/buku_backup.db
        printf "[+] Sending buku \n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                $home_folder/buku_backup.db \
                root@$IP:./sync_folder  "$@" > /dev/null
		rm $home_folder/buku_backup.db


		# Updatez timpul local de push pentru verificare ultirioara cu serverul
		time=$(date +%s)
		echo $home_folder > last_push.log
		echo $time >> last_push.log

        printf "[+] Sending last_push.log file \n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                last_push.log \
                root@$IP:./sync_folder  "$@" > /dev/null
fi

## PULL
if [ "$operation" = 'l' -o "$operation" = 'pull' -o "$operation" = 'Pull' ]; then

		read -p "[?] Home folder? " home_folder

		printf "[+] Pulling from backup server\n"
        printf "[+] Getting keep file\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                root@$IP:./sync_folder/keep.com  $home_folder/. "$@" > /dev/null
 


        printf "[+] Pulling vimwiki\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                root@$IP:./sync_folder/vimwiki/ $home_folder/vimwiki  "$@" > /dev/null 


        printf "[+] Pulling tools folder\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                root@$IP:./sync_folder/tools/ $home_folder/Documents/tools "$@" > /dev/null 


        printf "[+] Pulling notes folder\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                root@$IP:./sync_folder/notes/ $home_folder/Documents/notes "$@" > /dev/null 


        printf "[+] Pulling research folder\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                root@$IP:./sync_folder/research/ $home_folder/Documents/research "$@" > /dev/null 
                

        printf "[+] Getting buku file\n"
        rsync -rzv -e 'ssh -p $PORT' --progress \
                root@$IP:./sync_folder/buku_backup.db $home_folder/. "$@" > /dev/null 
        buku -i $home_folder/buku_backup.db 2> /dev/null
        rm $home_folder/buku_backup.db "$@" > /dev/null 

		# Fac tipul local 0. Asa voi sti ca am facut pull
		echo $home_folder > last_push.log
		echo 0 >> last_push.log
fi

if [ "$operation" = 'w' -o "$operation" = 'who' -o "$operation" = 'Who' ]; then
		#read -p "[?] Home folder? " home_folder
		home_folder=$HOME

		printf "\nColoana local arata ultima operatatie de pe masina asta:
* Time 0: am facut pull
* Time > 0: timpul la care am facut push de aici
* Local time == Remote time: ultimul push la server a fost facut de aici. Nu este nevoie de pull
* Local time < Remote time: ultimul push la server a fost facut din alta parte. Trebuie facut pull\n\n"

		# Iau fisierul de pe server pentru a vedea cand si de catre cine s-a facut ultimul push
		rsync -rzv -e 'ssh -p $PORT' --progress \
				root@$IP:./sync_folder/last_push.log  $home_folder/last_server_sync.log "$@" > /dev/null

		mapfile -t array < $home_folder/last_server_sync.log
		server_time=${array[1]} # memorez cand s-a inregistrat pe server ultimul push
		server_user=${array[0]} # memorez userul care a facut push ultima data pe server

		local_user=$(sed -n 1p last_push.log)
		local_time=$(sed -n 2p last_push.log)

		printf "Local\t\t\tRemote\n"
		printf "User: %s\tUser: $server_user\n" $local_user
		printf "Time: %10s\tTime: $server_time\n" $local_time
fi

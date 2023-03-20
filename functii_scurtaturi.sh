#!/bin/bash

#========== Aliases ==========
alias ll='ls -alF'
alias la='ls -A'
alias ee='exit'
alias tcowndown='nvim $LOCATION_OF_UTILITIES_FOLDER/countdown.tasks'
alias eb='nvim ~/.bashrc'
alias cdex='cd ~/projects/exercises/'
alias cdut='cd ~/projects/utility_scripts/'
alias cdav='cd ~/projects/avocati/'
alias cdavf='cd ~/projects/avocati/info_avovati_server_python/'
alias cdava='cd ~/projects/avocati/proiect_avocati_frontend/src/app/'
alias cdavd='cd ~/projects/avocati/docker_files/'
alias cddw='cd ~/Downloads/'
alias cdd='cd ~/Documents/'
alias rm=sendToTrash $*
#alias cat='cat -n'
alias cat='bat'
alias pp='ping -a -c 4 www.google.com'
alias identity='python ~/projects/utility_scripts/generate_account.py'
alias .='vifm .'
alias all_time_script='sh $LOCATION_OF_UTILITIES_FOLDER/make_all_time_script.sh'
alias rbal='read_bookmark_at_line'
alias open_nautilus='python $LOCATION_OF_UTILITIES_FOLDER/open_nautilus.py'
alias locations='python3.10 $LOCATION_OF_UTILITIES_FOLDER/locations.py'
alias lc='python3.10 $LOCATION_OF_UTILITIES_FOLDER/locations.py'
alias codesearch='python $LOCATION_OF_UTILITIES_FOLDER/code-search.py $PWD $1 $2'
alias aa='open_alacrity_here'
#========== End of aliases ==========   


#========== ANSI color codes ==========
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

# Exemple cursoare
# export PS1="$BBLE \W $ $RS " After tesing activate this
# export PS1="$BMAG \W $ $RS " # Only for docker testing

function sendToTrash() {
	read -p "Remove? "$*
	trash $*
}

function tryRemoveFile() {
	if [ "$#" -ne 1 ]; then
		return 0
	fi

	if [ -e $1 ]; then
		rm $1
	fi
}

function tab-name() {
	newName="$*"
	PROMPT_COMMAND='echo -en "\033]0;$newName\a"'
	export title=$newName
}

function cowntdown() {
	cd $LOCATION_OF_UTILITIES_FOLDER
	python $LOCATION_OF_UTILITIES_FOLDER/countdown.py $LOCATION_OF_UTILITIES_FOLDER/countdown.tasks
}

function replace_spaces() {
	python $LOCATION_OF_UTILITIES_FOLDER/replace_spaces_in_filenames.py $1
}

function numberlines() {
	# awk '{ print NR": "$0 }' < inputfile
	# alternative to cat -n
	for filename in "$@"
	do
		linecount="1"
		while IFS="\n" read line
		do
			echo "${linecount}: $line"
			linecount="$(( $linecount + 1 ))"
		done < $filename
	done 
}


function findsuid() {
	# findsuid--Checks all SUID files or programs to see if they're writeable,
	# and outputs the matches in a friendly and useful format
	mtime="7"
	verbose=0
	# How far back (in days) to check for modified cmds.
	# By default, let's be quiet about things.
	if [ "$1" = "-v" ] ; then
		verbose=1 # User specified findsuid -v, so let's be verbose.
	fi
	# find -perm looks at the permissions of the file: 4000 and above
	# are setuid/setgid.
	find / -type f -perm +4000 -print0 | while read -d '' -r match
	do
		if [ -x "$match" ] ; then
			# Let's split file owner and permissions from the ls -ld output.

			owner="$(ls -ld $match | awk '{print $3}')"
			perms="$(ls -ld $match | cut -c5-10 | grep 'w')"

			if [ ! -z $perms ] ; then
				echo "**** $match (writeable and setuid $owner)"
			elif [ ! -z $(find $match -mtime -$mtime -print) ] ; then
				echo "**** $match (modified within $mtime days and setuid $owner)"
			elif [ $verbose -eq 1 ] ; then
				# By default, only dangerous scripts are listed. If verbose, show all.
				lastmod="$(ls -ld $match | awk '{print $6, $7, $8}')"
				echo " $match (setuid $owner, last modified $lastmod)"
			fi
		fi
	done
}

searchterm=""
merge_arguments(){
	str=
	connector="+"
	for i in "$@"; do
		str="$str$connector$i"
	done
	searchterm=${str:1}
}

#Use like this
#merge_arguments $*
#echo $searchterm


search() {
	merge_arguments $*
	search_string="duckduckgo.com/?q=$searchterm&t=canonical&atb=v77-1&ia=web"
	printf "Choose browser: \n1. Firefox \n2. Chrome\n3. W3M\n4. Qute\n5. Midori\n"
	read userResponse
	if [ $userResponse -eq 1 ]; then
		firefox $search_string
	fi

	if [ $userResponse -eq 2 ]; then
		google-chrome $search_string
	fi

	if [ $userResponse -eq 3 ]; then
		w3m $search_string
	fi

	if [ $userResponse -eq 4 ]; then
		qutebrowser $search_string
	fi

	if [ $userResponse -eq 5 ]; then
		midori "http://www."$search_string
	fi
}

# LOCATION_OF_RESEARCH_FOLDER este in .bashrc pusa de install_system.sh
go_to_today_scripts() {
	base_path=$LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/$date
	date=$(date '+%Y-%m-%d')
	cd $base_path/$date
	ls
}

# grep in keep
gik() {
	grep $1 $LOCATION_OF_KEEP/keep.com
}

cheat() {

	if [ "$#" -eq 1 ]; then
		curl cheat.sh/$1
	fi

	if [ "$#" -eq 0 ]; then
		curl cheat.sh
	fi
}

connect_monitor() {
	if [ "$#" -eq 0 ]; then
		echo "Ce fel de monitor? [usb_normal, usb_vertical]"
	fi

	if [ "$1" = "usb_normal" ]; then
		xrandr --output DVI-I-2-1 --auto --right-of eDP-1-1 --rotate normal
	elif [ "$1" = "usb_vertical" ]; then
		xrandr --output DVI-I-2-1 --auto --right-of eDP-1-1 --rotate left
	elif [ "$1" = "hdmi" ]; then
		xrandr --output HDMI-0 --auto --right-of eDP-1-1
	else 
		echo "Ce fel de monitor? [usb_normal, usb_vertical]"
	fi

}

# Functie cu care sa controlez releul care porneste ceasul
# Fac apel la web-serverul pornit local la IP-ul 192.168.1.5. Se poate modifica si trebuie modifica aici
clock() {
	# Daca conditia dintr [[ <conditie> ]] atunci fac si comanda curl
	[[ "$1" = "on" ]] && curl http://192.168.1.5/turn-off && echo "Turn on"

	[[ "$1" = "off" ]] && curl http://192.168.1.5/turn-on && echo "Turn off"
}

open_alacrity_here() {
	alacritty &
}

title() {
	echo -en "\e]2;$1\a"
}

go_to_proiecte() {
	echo "1. vimwiki"
	echo "2. midocean"
	echo "3. tripis"
	echo "4. ebloc"
	echo "5. utilities"

	read -p "[?] Project: " project

	if [ "$project" = 1 ]; then
		cd ~/vimwiki
	elif [ "$project" = 2 ]; then 
		cd ~/projects/midocean
	elif [ "$project" = 3 ]; then 
		cd ~/projects/tripis
	elif [ "$project" = 4 ]; then 
		cd ~/projects/e-bloc.ro
	elif [ "$project" = 5 ]; then 
		cd ~/projects/utility_scripts
	fi
}

# Ruleaza scriptul python din utilities folder/day-end/dayend.py
# Verifica daca am Python3 instalat. Daca nu am renunta
finale() {
	ver=$(python --version 2>&1 | tee)
	IFS='.' read -a fields <<<"$ver"
	part1=${fields[0]}

	if [ "$part1" != "Python 3" ]; then
		echo "Need to use Python 3 to run this."
		echo "Current version: " $ver

		return 1
	fi

	python $LOCATION_OF_UTILITIES_FOLDER/day-end/dayend.py
}

# Reads from the vimwiki folder, from a bookmarks file and opens in the nvim
# In the bookmark file, each line should be something like:
# +145 absolutefilepath
# In this case the bookmarks file is ~/vimwiki/Models.wiki
# should absolutely pass the line number of the bookmark want to open
read_bookmark_at_line() {
	nvim $(sed -n "$1 p;$1 q" $LOCATION_OF_VIMWIKI/ModelsBookmarks.wiki)
}
alias rbal='read_bookmark_at_line' 

search_bookmark_at_line() {
	grep -nr --ignore-case -A 1 $1 $LOCATION_OF_VIMWIKI/ModelsBookmarks.wiki
}
alias sbal='search_bookmark_at_line'

# Ruleaza scriptul comenzi.py din folderul utility_sripts pentru a gasi o comanda salvata
# Afiseaza comenzile gasite si la executa daca are confirmare
# Trebuie dat termenul dupa care sa caute
#
# Usage:
# seach_comenzi textToSearch
search_comenzi() {
	python $LOCATION_OF_UTILITIES_FOLDER/comenzi.py $1
}


# Cauta textul din parametrul 1 in ~/vimwiki folder si in ~/projects
# Trebuie adaugata si terminatia
#
# Usage:
# notes-search textToSearch fileExtension
notes-search() {
	if [[ "$#" -lt 2 ]];then
		echo "Usage:"
		echo "notes-search textToSearch fileExtension"
		echo "             ^^^^^^^^^^^^ ^^^^^^^^^^^^^"
		return
	fi

	printf "\n"
	pushd $LOCATION_OF_VIMWIKI > /dev/null
	python $LOCATION_OF_UTILITIES_FOLDER/code-search.py $PWD $1 wiki
	popd > /dev/null

	# Generez graficul bazat pe rezultatele gasite din scriptul notes-graph.py
	printf "\n"
	read -p "[?] Search in ~/projects (y/n)" ans
	if [ "$ans" = "y" ]; then
		printf "\n"
		pushd ~/projects > /dev/null
		python $LOCATION_OF_UTILITIES_FOLDER/code-search.py $PWD $1 $2
		popd > /dev/null
	fi


	local dot_installed="$(package_installed graphviz)"
	local eog_installed="$(package_installed eog)"

	# Daca nu este instalat dot si eog nu pot face graficul
	if [[ "$dot_installed" == 1 && "$eog_installed" == 1 ]];then
		printf "\n"
		read -p "[?] Make graph (y/n)" ans
		if [[ "$ans" = "y" ]];then
			printf "\n"
			pushd $LOCATION_OF_UTILITIES_FOLDER/notes-graph > /dev/null
			python notes-graph.py $1

			# Testez daca s-a generat input.dot
			if [[ -e input.dot ]];then
				dot -Tsvg input.dot > output.svg
				popd > /dev/null

				# Testez daca am dot a generat fisierul svg
				if [[ -e $LOCATION_OF_UTILITIES_FOLDER/notes-graph/output.svg ]];then 
					eog $LOCATION_OF_UTILITIES_FOLDER/notes-graph/output.svg
				else
					echo "comanda dot nu a generat output.svg"
				fi
			else
				echo "Nu s-a generat input.dot de catre notes-graph.py"
			fi

		fi
	else
		echo "Am nevoie de dot si eog pentru a genera si vizualiza graficul"
	fi
}


# Printeaza o lista de variante python
# Aleg ce varianta vreau sa ii fac symlink denumit "python" in /usr/bin
set-python() {
	if [ -f /usr/bin/python ]; then
		echo "/usr/bin/python binary already exists. Ce facem acum?"
		v=$(/usr/bin/python --version)
		printf "\nVersion:\n$v\n"
		printf "\nBinary:\n"
		# de la comanda ll /usr/bin/ selectez doar ce contine python si printez ultimele 3 coloane. Selectez doar cel cu numele python
		ll /usr/bin/ | grep python | awk '{print $9 $10 $11}' | grep "python->"
		return 1
	fi

	options=$(ls -1 /usr/bin/python*)

	# Split options by character '\n'
	readarray -t options_lines <<< $options

	# ${#array[@]} is the number of elements in the array
	for i in ${!options_lines[@]}; do
		echo [$(($i+1))] ${options_lines[$i]}
	done

	read -p "[?] Choose which binary to link to /usr/bin/python executable " ans

	index=$(($ans-1))
	echo ${options_lines[$index]}

	sudo ln -s ${options_lines[$index]} /usr/bin/python
}

function set-monitor-xrandr() {
	if [[ "$#" == 0 ]];then
		echo "Usage:"
		echo "set-monitor-xrandr 1 - Pentru a seta pentru monitoarele mari. LG dreapta, AOC stanga"
		echo "set-monitor-xrandr 2 - Cazul laptop DELL gabi, cu monitorul portabil in stanga"
		return
	fi

	# Pentru a afla ce monitoare am:
	monitors_connected=$(xrandr | grep "\bconnected" | awk '{print $1}')

	# Va fi 1 daca am conectat monitorul portabil
	monitor_portabil=0
	for m in $monitors_connected
	do
		if [[ "$m" == "DVI-I-2-1" ]];then
			echo "Monitor portabil connected"
			monitor_portabil=1
		fi
	done

	case "$1" in
		1) # LG dreapta, AOC stanga
			echo Just brightness. Fa si orientarea
			xrandr --output DP-1 --gamma 1.0:0.9:0.8 --brightness 1.0
			;;
		2) # Laptop DELL gabi, monitor portabil in stanga
			xrandr --output DVI-I-2-1 --auto --left-of eDP-1
			;;
		*) # unknown/unsupported option
			echo "Unsupported option"
			return 2;;
	esac
}

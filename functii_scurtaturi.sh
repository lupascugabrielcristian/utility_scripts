#!/bin/bash

utilities_folder='/home/cristi/projects/utility_scripts'

#========== Aliases ==========
alias ll='ls -alF'
alias la='ls -A'
alias ee='exit'
alias tcowndown='nvim $utilities_folder /tasks'
alias eb='nvim ~/.bashrc'
alias cdex='cd ~/projects/exercises/'
alias cdut='cd ~/projects/utility_scripts/'
alias cddw='cd ~/Downloads/'
alias cdd='cd ~/Documents/'
alias rm=sendToTrash $*
alias cat='cat -n'
alias pp='ping -a -c 4 www.ubuntu.security.com'
alias identity='python3.8 ~/projects/utility_scripts/generate_account.py'
alias .='vifm .'
alias all_time_script='sh /home/cristi/projects/utility_scripts/make_all_time_script.sh'
alias buku_put_in_utilities='cp /home/cristi/.local/share/buku/bookmarks.db ~/projects/utility_scripts/buku_database/'
alias rbal='read_bookmark_at_line'
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
export PS1="$BBLE \W $ $RS "

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
	cd $utilities_folder
	python3 $utilities_folder/countdown.py $utilities_folder/countdown.tasks
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

letstor() {
	torsocks w3m 'https://check.torproject.org/'
}

firefoxdev() {
	~/Downloads/firefox-69.0b12/firefox/firefox $1
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

go_to_today_scripts() {
	base_path=/home/cristi/Documents/research/all_the_time_scrips/$date
	date=$(date '+%Y-%m-%d')
	cd $base_path/$date
	ls
}

gik() {
	grep $1 /home/cristi/keep.com
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

	if [ "$1" = "usb_normal" ]; then
		xrandr --output DVI-I-2-1 --auto --right-of eDP-1-1 --rotate normal
	fi

	if [ "$1" = "usb_vertical" ]; then
		xrandr --output DVI-I-2-1 --auto --right-of eDP-1-1 --rotate left
	fi

	if [ "$#" -eq 0 ]; then
		echo "Ce fel de monitor? [usb_normal, usb_vertical]"
	fi
}

# Reads from the vimwiki folder, from a bookmarks file and opens in the nvim
# In the bookmark file, each line should be something like:
# +145 absolutefilepath
# In this case the bookmarks file is ~/vimwiki/Models.wiki
# should absolutely pass the line number of the bookmark want to open
read_bookmark_at_line() {
	nvim $(sed -n "$1 p;$1 q" /home/cristi/vimwiki/ModelsBookmarks.wiki)
}
alias rbal='read_bookmark_at_line' 

search_bookmark_at_line() {
	grep -nr --ignore-case -A 1 $1 /home/cristi/vimwiki/ModelsBookmarks.wiki
}
alias sbal='search_bookmark_at_line'



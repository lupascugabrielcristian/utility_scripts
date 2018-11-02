# ANSI color codes
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

# Aliases
alias rm=sendToTrash $*

function downloads() {
	nautilus ~/Downloads/
}

function w3m-google() {
	googleSearchPage="https://www.google.com/search?client=ubuntu&channel=fs&q="
	all=""
	all="$*"
	searchString=""
	for word in $all; do
		searchString=$searchString+$word
	done
	searchString=${searchString:1}
	echo Searching for $searchString
	w3m $googleSearchPage$searchString
}

function search-google() {
	googleSearchPage="https://www.google.com/search?client=ubuntu&channel=fs&q="
	all=""
	all="$*"
	searchString=""
	for word in $all; do
		searchString=$searchString+$word
	done
	searchString=${searchString:1}
	echo Searching for $searchString
	sensible-browser $googleSearchPage$searchString
}

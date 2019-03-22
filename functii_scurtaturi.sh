
#========== Aliases ==========
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ee='exit'
alias tcowndown='nvim ~/Documents/utility_scripts/tasks'
alias editbash='nvim ~/.bashrc'
alias cdsk='cd ~/Documents/SkyKit/'
alias cdex='cd ~/Documents/exercises/skykitStart/'
alias cdut='cd ~/Documents/utility_scripts/'
alias rm=sendToTrash $*

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
}

function cowntdown() {
	cd ~/Documents/utility_scripts/
	python3 ~/Documents/utility_scripts/countdown.py
}

letstor() {
	torsocks w3m 'https://check.torproject.org/'
}



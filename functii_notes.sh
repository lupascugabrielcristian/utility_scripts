
######### Functii pentru notes ########

function n() { 
	 nvim ~/Documents/notes/"$*".md 
}

function nn() {
	cd ~/Documents/notes/
	ll
}

function nls() { 
	 ls -c ~/Documents/notes/ | grep "$*" 
}

function no() {
	files=$(ls ~/Documents/notes/ | grep "$*")
	echo $files
	nvim ~/Documents/notes/$files 
}

function degandit() {
	firefox "https://drive.google.com/drive/u/1/folders/1QSa3CpWR3RTAAXPTbnv5vAvd-rdy3sTi"
}

function xmind() {
	# Am incercat doar cu rrun.sh deja facut si facut executabil
	SCRIPT_PATH="~/Downloads/xmind-8-update8-linux/XMind_amd64"
	if [ "$#" -ne 1 ]; then
		echo "./XMind" > ~/Downloads/xmind-8-update8-linux/XMind_amd64/rrun.sh
	else 
		echo ./XMind ~/Documents/notes/"$1".xmind > ~/Downloads/xmind-8-update8-linux/XMind_amd64/rrun.sh
	fi

	$(cd ~/Downloads/xmind-8-update8-linux/XMind_amd64/ ; ./rrun.sh)
}

function ndia() {
	if [ "$#" -ne 1 ]; then
		echo "No arguments. Starting DIA"
		dia
	else 
		dia ~/Documents/notes/"$1".dia
	fi
}

########################################

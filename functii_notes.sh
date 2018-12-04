
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
	/home/cristi/Downloads/xmind-8-update8-linux/XMind_amd64/XMind ~/Documents/notes/"$1".xmind
}

########################################


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

########################################

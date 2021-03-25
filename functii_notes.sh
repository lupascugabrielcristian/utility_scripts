# Variabila LOCATION_OF_UTILITIES_FOLDER este pusa in .bashrc la executia install_system.sh
# si are valoarea $PWD deci este locatia de unde este executat ./install_system.sh
function oa(){
	python3.8 $LOCATION_OF_UTILITIES_FOLDER/mongo_notes/allNotes.py $*
}

function n() { 
	 nvim /home/cristi/Documents/notes/"$*".md 
}

function nn() {
	cd /home/cristi/Documents/notes/
	ll
}

function nls() { 
	 ls -c /home/cristi/Documents/notes/ | grep "$*" 
}

function no() {
	files=$(ls ~/Documents/notes/ | grep "$*")
	echo $files
	nvim /home/cristi/Documents/notes/$files 
}


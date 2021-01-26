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

function degandit() {
	firefox "https://drive.google.com/drive/u/1/folders/1QSa3CpWR3RTAAXPTbnv5vAvd-rdy3sTi"
}

function xxmind() {
	SCRIPT_PATH="~/Downloads/xmind-8-update8-linux/XMind_amd64"

	if [ "$#" -ne 1 ]; then
		echo "No arguments. Starting XMIND"
		echo "./XMind &" > ~/Downloads/xmind-8-update8-linux/XMind_amd64/rrun.sh
	else 
		files=(`ls ~/Documents/notes/ | grep "$*" | grep xmind`)
		if [ ${#files} -eq 0 ]; then
			echo "No files match patttern"
			return
		fi
		echo First file to match is ${files[0]}
		com="./XMind ~/Documents/notes/${files[0]} &"
		echo $com > ~/Downloads/xmind-8-update8-linux/XMind_amd64/rrun.sh
	fi

	$(cd ~/Downloads/xmind-8-update8-linux/XMind_amd64/ ; ./rrun.sh)
}

function ndia() {
	if [ "$#" -ne 1 ]; then
		echo "No arguments. Starting DIA"
		dia
	else 
		dia /home/cristi/Documents/notes/"$1".dia
	fi
}

function oa(){
	#source /home/cristi/Documents/utility_scripts/mongo_notes/env/bin/activate
	python3.8 /home/cristi/projects/utility_scripts/mongo_notes/allNotes.py $*
	#deactivate
}

alias mn='mongo_notes'
mongo_notes(){
	source /home/cristi/Documents/utility_scripts/mongo_notes/env/bin/activate
	python3.6 /home/cristi/Documents/utility_scripts/mongo_notes/add_mongo_note.py $*
	deactivate
	if [ "$#" -eq 0 ]; then
		echo "Exporting database collection"
		mongoexport --db notes_database --collection notes_collection --out ~/Documents/utility_scripts/notes_database.mongoexport
	fi
}

alias cmn='change_mongo_note'
function change_mongo_note() {
	source /home/cristi/Documents/utility_scripts/mongo_notes/env/bin/activate
	python3.6 /home/cristi/Documents/utility_scripts/mongo_notes/change_mongo_note.py $*
	deactivate
	echo "Exporting database collection"
	mongoexport --db notes_database --collection notes_collection --out ~/Documents/utility_scripts/notes_database.mongoexport
}

alias smn='search_mongo_notes'
function search_mongo_notes() {
	source /home/cristi/Documents/utility_scripts/mongo_notes/env/bin/activate
	python3.6 /home/cristi/Documents/utility_scripts/mongo_notes/search_mongo_note.py $*
	deactivate
}


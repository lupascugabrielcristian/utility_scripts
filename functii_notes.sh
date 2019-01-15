

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
		dia ~/Documents/notes/"$1".dia
	fi
}

function printOptions() {
	COUNTER=0
	for f in $1 ; do
		printf "\033[32m $COUNTER \033[33m ${f} \033[0m \n"
		let COUNTER=COUNTER+1
	done
}

function openNotes() {
	NOTES=`ls -l ~/Documents/notes/ | grep -e .md -e .txt | grep -i $1 | awk '{print $9}'`
	if [ ${#NOTES} -eq 0 ]; then
		echo "no note found"
	else
		printOptions $NOTES
		read -p "which one?(index number)" index
		echo "Opening note ${NOTES[$index]}"
		no ${NOTES[$index]}
		return
	fi
}

function openXmindNotes() {
	XMIND_FILES=`ls -l ~/Documents/notes/ | grep .xmind | grep -i $1 | awk '{print $9}'`
	if [ ${#XMIND_FILES} -eq 0 ]; then
		echo "XMIND file not found"
	else
		echo "XMIND files found"
		printOptions $XMIND_FILES
		read -p "which one?(index number)" index
		xmind ${XMIND_FILES[$index]}
		return
	fi
}

function openVimDotNotes() {
	VIMDOT_FILES=`ls -l ~/Documents/notes/ | grep .gv | grep -i $1 | awk '{print $9}'`
	if [ ${#VIMDOT_FILES} -eq 0 ]; then
		echo "VIMDOT file not found"
	else
		echo "VIMDOT files found"
		printOptions $VIMDOT_FILES
		read -p "which one?(index number)" index
		vimdot ~/Documents/notes/${VIMDOT_FILES[$index]}
	fi
}

function openDiaNotes() {
	DIA_FILES=`ls -l ~/Documents/notes/ | grep .dia | grep -i $1 | awk '{print $9}'`
	if [ ${#DIA_FILES} -eq 0 ]; then
		echo "DIA file not found"
	else
		echo "DIA files found"
		printOptions $DIA_FILES
		read -p "which one?(index number)" index
		dia ~/Documents/notes/${DIA_FILES[$index]}
		return
	fi
}

function openBooks() {
	PDF_FILES=`ls -l ~/Documents/Books/ | grep .pdf | grep -i $1 | awk '{print $9}'`
	if [ ${#PDF_FILES} -eq 0 ]; then
		echo "No books found"
	else
		echo "PDF files found"
		printOptions $PDF_FILES
		read -p "which one?(index number)" index
		evince ~/Documents/Books/${PDF_FILES[$index]}  # I'm assuming that evince is by default installed
	fi
}

function searchOnGoogle() {
	googleSearchPage="https://www.google.com/search?client=ubuntu&channel=fs&q="
	all=""
	all="$*"
	searchString=""
	for word in $all; do
		searchString=$searchString+$word
	done
	searchString=${searchString:1}
	read -p "Searching on google for $searchString. OK?"
	w3m $googleSearchPage$searchString
}

alias oa='open_any'
function open_any() {
	if [ "$#" -lt 1 ]; then
		echo "No arguments. Need an argument"
		read -p "OK?[Enter]"
		return
	fi

	openNotes $1
	openXmindNotes $1
	openDiaNotes $1
	openBooks $1
	openVimDotNotes $1
	searchOnGoogle $*
}


############## END FUNCTII NOTES ##########################




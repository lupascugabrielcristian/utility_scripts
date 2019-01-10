
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

function openNotes() {
	NOTES=`ls -l ~/Documents/notes/ | grep -e .md -e .txt | grep $1 | awk '{print $9}'`
	if [ ${#NOTES} -eq 0 ]; then
		echo "no note found"
	else
		COUNTER=0
		echo "A note is found!"
		for f in $NOTES ; do
			printf "\033[32m $COUNTER \033[33m ${f} \033[0m \n"
			let COUNTER=COUNTER+1
		done
		read -p "which one?(index number)" index
		# change the note
		echo "Opening note ${NOTES[$index]}"
		return
	fi
}

function openXmindNotes() {
	XMIND_FILES=`ls -l ~/Documents/notes/ | grep .xmind | grep $1 | awk '{print $9}'`
	if [ ${#XMIND_FILES} -eq 0 ]; then
		echo "xmind file not found"
	else
		echo "xmind files found"
		for f in $XMIND_FILES ; do
			echo ${f}
		done
		read -p "which one?(index number)" index
		# xmind ${XMIND_FILES[$index]}
		echo "Opening xmind with parameters" ${XMIND_FILES[$index]}
		return
	fi
}

function openDiaNotes() {
	DIA_FILES=`ls -l ~/Documents/notes/ | grep .dia | grep $1 | awk '{print $9}'`
	if [ ${#DIA_FILES} -eq 0 ]; then
		echo "DIA file not found"
	else
		echo "DIA files found"
		for f in $DIA_FILES ; do
			echo ${f}
		done
		read -p "which one?(index number)" index
		#dia ~/Documents/notes/${DIA_FILES[$index]}
		echo "opening in DIA file ${DIA_FILES[$index]}"
	fi

	echo $diaFiles
}

function openBooks() {
	PDF_FILES=`ls -l ~/Documents/Books/ | grep .pdf | grep $1 | awk '{print $9}'`
	if [ ${#PDF_FILES} -eq 0 ]; then
		echo "PDF file not found"
	else
		echo "PDF files found"
		for f in $PDF_FILES ; do
			echo ${f}
		done
		read -p "which one?(index number)" index
		# Need to make sure that evince is installed
		# evince ~/Documents/Books/${PDF_FILES[$index]} 
		echo "opening in PDF file ${PDF_FILES[$index]}"
	fi

	echo $diaFiles
}


alias oa='open_any'
function open_any() {
	if [ "$#" -ne 1 ]; then
		echo "No arguments. Need an argument"
		read -p "OK?[Enter]"
		return
	fi

	openNotes $1
	openXmindNotes $1
	openDiaNotes $1
	openBooks $1
	# search on google
}
########################################

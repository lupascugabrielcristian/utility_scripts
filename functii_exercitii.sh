
function ts() { 
	 nvim ~/Documents/notes/exercitii/ts/"$*".ts 
}


function exls() {
	DIRS=`ls -l ~/Documents/notes/exercitii/ | egrep '^d' | awk '{print $9}'`
	for d in $DIRS ; do
		echo ${d}
		echo  '================='
		ls ~/Documents/notes/exercitii/$d
	done
}


function mindmap() {
	sensible-browser "https://drive.google.com/drive/u/1/folders/1QSa3CpWR3RTAAXPTbnv5vAvd-rdy3sTi"
}

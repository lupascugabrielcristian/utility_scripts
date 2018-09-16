
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




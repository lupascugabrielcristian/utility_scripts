
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

new_project_css() {
	printf "\nCreating a CSS project means create a HTML page, a JS script and a style CSS file\n\n"

	if [ $# -eq 0 ]; then
		echo "Need a name for the new project"
		exit 1
	fi

	PROJECT_NAME=/home/cristi/Documents/exerciti/css/$1
	mkdir $PROJECT_NAME
	touch $PROJECT_NAME/$1.html
	touch $PROJECT_NAME/project_scripts.js
	touch $PROJECT_NAME/styles.css

	cp require/bootstrap/js/bootstrap.min.js $PROJECT_NAME/bootstrap.min.js
	cp require/bootstrap/js/bootstrap.min.js.map $PROJECT_NAME/bootstrap.min.js.map
	cp require/bootstrap/css/bootstrap.min.css $PROJECT_NAME/bootstrap.min.css
	cp require/bootstrap/css/bootstrap.min.css.map $PROJECT_NAME/bootstrap.min.css.map
	cp require/jquery-3.3.1.min.js $PROJECT_NAME/jquery.min.js

	HTML="
	<html>\n
		\t<head>\n
			\t<script type="text/javascript" src="bootstrap.min.js"></script>\n
			\t<script type="text/javascript" src="jquery.min.js"></script>\n
			\t<link rel="stylesheet" href="bootstrap.min.css">\n
			\t<link rel="stylesheet" href="styles.css">\n
		\t</head>\n
		\t<body>\n
			\t<p>Hello $PROJECT_NAME</p>
			\t<script type="text/javascript" src="project_scripts.js"></script>\n
		\t</body>\n
	</html>
	"
	echo -e $HTML > $PROJECT_NAME/$1.html
}

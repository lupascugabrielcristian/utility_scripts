printf "\nCreating a CSS project means create a HTML page, a JS script and a style CSS file\n\n"

if [ $# -eq 0 ]; then
	echo "Need a name for the new project"
	exit 1
fi

PROJECT_NAME=$1
mkdir $PROJECT_NAME
touch $PROJECT_NAME/$PROJECT_NAME.html
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
echo -e $HTML > $PROJECT_NAME/$PROJECT_NAME.html

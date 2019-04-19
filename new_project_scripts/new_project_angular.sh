printf "\nCreating an Angular project \n\n"

if [ $# -eq 0 ]; then
	echo "Need a name for the new project"
	exit 1
fi

PROJECT_NAME=$1
ng new $PROJECT_NAME
cd $PROJECT_NAME
ng serve -o

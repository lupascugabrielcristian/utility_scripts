printf "\nCreating a typescript project \n\n"

if [ $# -eq 0 ]; then
	echo "Need a name for the new project"
	exit 1
fi

PROJECT_NAME=$1
mkdir $PROJECT_NAME

cd $PROJECT_NAME
touch $PROJECT_NAME.ts
npm i @types/core-js
cp ../tsconfig.json tsconfig.json

echo "console.log('hello');" > $PROJECT_NAME.ts


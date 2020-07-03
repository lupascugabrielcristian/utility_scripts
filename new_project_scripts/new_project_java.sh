#!/bin/bash


if [ $# -eq 0 ]; then
	echo "Need a name for the new project"
	exit 1
fi

PROJECT_NAME=$1
mkdir /tmp/$PROJECT_NAME

touch /tmp/$PROJECT_NAME/$PROJECT_NAME.java

echo "public class $PROJECT_NAME {

	public static void main( String[] args ) {
		System.out.println(\"ok good\");
	}

}
" > /tmp/$PROJECT_NAME/$PROJECT_NAME.java
printf "\nCreated java project at /tmp/$PROJECT_NAME \n\n"

cd /tmp/$PROJECT_NAME/
javac $PROJECT_NAME.java
java $PROJECT_NAME

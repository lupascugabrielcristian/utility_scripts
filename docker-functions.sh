alias doImages='sudo docker images'
alias doContainers='sudo docker ps -a'

function doRmContainer() {
	if [ "$#" -eq 1 ]; then
		sudo docker rm "$1"
	else
		echo "Insert container id. doContainers"
	fi
}

alias dri='doRmImage'
function doRmImage() {
	if [ "$#" -eq 1 ]; then
		sudo docker image rm "$1"
	else
		echo "Insert image id. doImages"
	fi
}

alias dgi='doGoImage'
function doGoImage() {
	if [ "$#" -eq 1 ]; then
		sudo docker run -p 4200:80 -it "$1"
	else 
		echo "Need the name for the image to run"
	fi
}

function doGoContainer() {
	if [ "$#" -eq 1 ]; then
		docker start "$1" -p 4200:80
	else 
		echo "Need the id of the container"
	fi
}

alias db='doBuild'
function doBuild() {
	if [ "$#" -eq 1 ]; then
		tab-name BUILD
		sudo docker build -t "$1" .
	else
		echo "Need a name for the image"
	fi
}

alias dc='doCheck'
function doCheck() {
	printf "\n"
	doImages
	printf "\n\n"
	doContainers
}

alias dcl='doClean'
alias dp='sudo docker container prune'
alias dpi='sudo docker image prune -a'
alias du='docker-compose up'
function doClean() {
	read -p "Removes all containers and re-builds images. [OK?]"
	#sudo docker container prune
	#sudo docker image prune -a
	#sudo docker rm $(sudo docker ps -a -q)
	docker-compose rm
	docker-compose build
}

 function doPrepare() {
 	testDockerLocation=~/Documents/Docker # Modifica aici unde este Dockerfile
 	skykitDockerLocation=~/Documents/SkyKit/tools/Docker
 	printf "This is to copy to the Dockerfile location, all required files for the Skykit to work. Options are:
 		jars - Copying jar files and mongo scripts to test docker location
 		dist - Copying dist from SkyKit folder location to test docker location
 		mockup - Copying ASIMServerMockup folder from SkyKit project location to Docker test location
 		skykit - Copying required files for Docker from test docker location to Skykit project location\n\n"
 	for i in "${@}" 
 		do if [ "$i" == "jars" ]; then
 			echo "Copying jar files to test docker location and skykit docker location"
 			read -p "OK?[Enter]"
 			cp ~/Documents/SkyKit/backend/asim-adaptation/target/skykit-asim-adaptation.jar $testDockerLocation/compose/adaptation/
 			cp ~/Documents/SkyKit/backend/asim-integration/target/skykit-asim-integration.jar $testDockerLocation/compose/integration/
 			cp ~/Documents/SkyKit/backend/preview-web-api/target/skykit-preview-web-api.jar $testDockerLocation/compose/preview-back-end/

 			cp ~/Documents/SkyKit/backend/asim-adaptation/target/skykit-asim-adaptation.jar $skykitDockerLocation/compose/adaptation/
 			cp ~/Documents/SkyKit/backend/asim-integration/target/skykit-asim-integration.jar $skykitDockerLocation/compose/integration/
 			cp ~/Documents/SkyKit/backend/preview-web-api/target/skykit-preview-web-api.jar $skykitDockerLocation/compose/preview-back-end/
 		elif [ "$i" == "mockup" ]; then
 			echo "Copying ASIMServerMockup folder from SkyKit project location to Docker test location"
 			read -p "OK?[Enter]"
 			echo "Removing existing folder"
 			rm $testDockerLocation/continuare/run/ASIMServerMockup/
 			echo "Copying ASIMServerMockup folder"
 			cp -r ~/Documents/SkyKit/tools/ASIMServerMockup/ $testDockerLocation/continuare/run/ASIMServerMockup/
 		elif [ "$i" == "skykit" ]; then
 			echo "Copying required files for Docker from test docker location to Skykit project location"
 			read -p "OK?[Enter]"
 			tryRemoveFile $skykitDockerLocation/Dockerfile
 			cp $testDockerLocation/Dockerfile $skykitDockerLocation/Dockerfile
 
 			tryRemoveFile $skykitDockerLocation/continuare/Dockerfile
 			cp $testDockerLocation/continuare/Dockerfile $skykitDockerLocation/continuare/Dockerfile
 
 			tryRemoveFile $skykitDockerLocation/continuare/readme.md
 			cp $testDockerLocation/continuare/readme.md $skykitDockerLocation/continuare/readme.md
 
 			tryRemoveFile $skykitDockerLocation/continuare/config/default.conf
 			cp $testDockerLocation/continuare/config/default.conf $skykitDockerLocation/continuare/config/default.conf		
 
 			tryRemoveFile $skykitDockerLocation/continuare/run/skykit.sh
 			cp $testDockerLocation/continuare/run/skykit.sh $skykitDockerLocation/continuare/run/skykit.sh
 
 			rm -r $skykitDockerLocation/continuare/run/utils
 			mkdir $skykitDockerLocation/continuare/run/utils
 			cp -r ~/Documents/mongo_scripts/*.js $skykitDockerLocation/continuare/run/utils/
 		elif [ "$i" == "help" ]; then
 			read -p "OK?[Enter]"
 		else echo "$i - unknown option. Doing nothing"
 		fi
 	done
 }

function tryRemoveFile() {
	if [ "$#" -ne 1 ]; then
		return 0
	fi

	if [ -e $1 ]; then
		rm $1
	fi
}


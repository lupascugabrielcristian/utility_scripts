# ANSI color codes
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

# ANSI color codes for printf
RS2="\033[0m"    # reset
HC2="\033[1m"    # hicolor
UL2="\033[4m"    # underline
INV2="\033[7m"   # inverse background and foreground
FBLK2="\033[30m" # foreground black
FRED2="\033[31m" # foreground red
FGRN2="\033[32m" # foreground green
FYEL2="\033[33m"	# foreground yellow

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

# Opens cAdvisor panel
alias cadvisor='firefox http://localhost:8080/docker/'

alias dcb='docker-compose build $1'
alias dcd='docker-compose down'
alias dcu='docker-compose up -d --scale adaptation=0'
alias dcua='docker-compose up -d'
alias edit_docker_file='nvim ~/Documents/utility_scripts/docker-functions.sh'
function check_static() {
	printf "$FYEL2 Files at /usr/share/nginx/html in the container with given id $RS2 \n"
	docker exec -it "$1" ls /usr/share/nginx/html
}

dcmongo() {
	docker inspect mongodb | grep "\bGateway.*\?[0-9]"
}

dclogs() {
	docker-compose logs $1
}

dclogspreview() {
	docker-compose logs preview-back-end > ~/Desktop/docker-container-log.tmp
	sed -i '/Consumer raised exception/d' ~/Desktop/docker-container-log.tmp	
	sed -i '/Restarting Consumer/d' ~/Desktop/docker-container-log.tmp	
	sed -i -e 's/preview-back-end/[X]/g' ~/Desktop/docker-container-log.tmp	
	sed -i -r 's/.+  : /:[X]/g' ~/Desktop/docker-container-log.tmp	
	sed -i -e 's/ro.jlg.skykit.core./[SK]/g' ~/Desktop/docker-container-log.tmp	

	nvim ~/Desktop/docker-container-log.tmp
}

alias docker-home='firefox http://localhost:84'

refresh_preview() {
	# Stop and removing
	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
	docker rm preview
	docker rm preview-back-end

	# Building 
	cd /home/cristi/Documents/SkyKit/frontend/preview-web
	ng b --prod

	# Starting
	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml up -d preview

	cd /home/cristi/Documents/SkyKit/tools/mongo_scripts
	mongo 127.0.0.1:27000/skykit < get_scenarios.js

	read -p "Go?" ans
	~/Downloads/firefox-69.0b12/firefox/firefox http://localhost:81/map/5ddbf6b9b8347400010a2388

	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
}

test_docker_home() {
	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
	docker rm preview
	docker rm preview-back-end
	docker rm home
	docker rm home-back-end

	# Building 
	cd /home/cristi/Documents/SkyKit/docker
	sh build_all_clients.sh
	sh build_all_servers.sh

	# Starting
	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml up -d home

	read -p "Go?" ans
	~/Downloads/firefox-69.0b12/firefox/firefox -devtools http://localhost:84

	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
}

test_designer_web() {
	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
	docker rm designer-web

	cd /home/cristi/Documents/SkyKit/docker/
	sh build_all_servers.sh

	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml up -d designer-web

	read -p "Go?" ans
	~/Downloads/firefox-69.0b12/firefox/firefox -devtools http://localhost:8091/#/airspace/view/5dd562ccaac20e0001fc5bf6

	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
}

show_scenarios() {
	pushd /home/cristi/Documents/SkyKit/tools/mongo_scripts
	mongo 127.0.0.1:27000/skykit < get_scenarios.js
	popd
}

test_docker_scenario() {
	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
	docker rm designer-web
	docker rm designer-back-end
	docker rm trajectory-generator

	pushd /home/cristi/Documents/SkyKit/docker/
	sh build_all_servers.sh
	popd

	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml up -d designer-web
	show_scenarios

	# http://localhost:8091/#/simulation/view/5df3911b27bb8d0001662929
	read -p "Scenario id: " scenario_id
	~/Downloads/firefox-69.0b12/firefox/firefox -devtools http://localhost:8091/#/simulation/view/$scenario_id

	docker-compose -f /home/cristi/Documents/SkyKit/docker/docker-compose.yml stop
}

help_functii_docker() {
	echo "test_docker_home - removes preview f&b containers, home f&b, re-builds and starts the browser"
	echo "test_designer_web - builds all server projects and starts the old designer in docker"
	echo "test_docker_scenario - restart docker containers specific to scenario view and opens the browser at location"
}


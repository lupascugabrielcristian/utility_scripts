read -p "Continue with updating bashrc file? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	echo -e '\nfunction preview() { \n\tsensible-browser "http://localhost:4200/map/5b7fc83bd69af0748e066545"\n}' >> ~/.bashrc
	echo -e '\nfunction designer() { \n\tsensible-browser "http://localhost:8091"\n}' >> ~/.bashrc
	echo -e '\nfunction tracker() { \n\tsensible-browser "http://tracker.jlg.ro/agiles/68-20/69-368"\n}' >> ~/.bashrc
	echo -e '\nfunction lastpass() { \n\tsensible-browser "https://lastpass.com/?ac=1"\n}' >> ~/.bashrc
fi

read -p "Continue with video card installation? This will reboot after. Continue from here(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt-get install nvidia-384
	sudo reboot
fi


read -p "Continue with notes setup(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d ~/Documents/notes ]; then
		mkdir ~/Documents/notes
	fi
	echo -e '\nfunction n() { \n\t nvim ~/Documents/notes/"$*".txt \n}' >> ~/.bashrc
	echo -e '\nfunction nls() { \n\t ls -c ~/Documents/notes/ | grep "$*" \n}' >> ~/.bashrc
	echo -e '\nfunction nup() { \n\t print("Implement this. Upload to dropbox") \n}' >> ~/.bashrc
	echo -e '\nfunction no() { \n\t	files=$(ls ~/Documents/notes/ | grep "$*") \n nvim ~/Documents/notes/$files \n }' >> ~/.bashrc
fi


read -p "Continue with exercitii setup(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d ~/Documents/exercitii ]; then
		mkdir ~/Documents/notes/exercitii
		mkdir ~/Documents/notes/exercitii/ts
	fi
	echo -e '\nfunction ts() { \n\t nvim ~/Documents/notes/exercitii/"$*".ts \n}' >> ~/.bashrc
fi


read -p "Continue with ASUS monitor installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sensible-browser 'http://www.displaylink.com/downloads/file?id=1123'
	read -p "Download driver in ~/Downloads folder then press to continue" varContinue
	mv ~/Downloads/DisplayLink* ~/Downloads/assus_driver.zip
	unzip $( find ~/Downloads -name assus_driver.zip ) -d ~/Downloads/ASSUS_DRIVER
	chmod +x ~/Downloads/ASSUS_DRIVER/displaylink*.run
	~/Downloads/ASSUS_DRIVER/displaylink-driver*.run --keep --noexec
	sensible-browser 'https://askubuntu.com/questions/744364/displaylink-asus-mb168b-issues'
	read -p "Update detect_distro function" varContinue
	vi displaylink-driver*/displaylink-installer.sh
	sudo ./displaylink-installer.sh install
fi

read -p "Continue with JDK installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt install openjdk-8-jdk
fi

read -p "Continue with git, node, npm, tsc and angular-cli installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt install tsc
	sudo apt install git
	sudo apt install node
	sudo apt install npm
	sudo apt install node-typescript
	sudo npm install -g @angular/cli

	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt-get install neovim
	sudo apt-get install htop
	sudo apt-get install synaptic
	sudo snap install slack --classic
	sudo snap install mailspring
	sudo snap install chromium
	sudo apt install klavaro
	sudo apt install curl
	sudo apt install bmon
	sudo apt install tcptrack
	sudo apt install graphviz

	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
	sudo apt-get update
	sudo apt-get install google-chrome-stable
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt-get install apt-transport-https
	sudo apt-get update
	sudo apt install code
	sudo apt install python-pip

fi

read -p "Continue with GIT configuration? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	git config --global user.name "Lupascu Gabriel Cristian"
	git config --global user.email "lupascugabrielcristian@gmail.com"
fi

read -p "Continue with VIM configuration? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo echo -e '\nset nu' >> ~/.vimrc
fi

# Mongo installation
read -p "Continue with MongoDB installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	echo '\n\n====== Mongo instaltion =====\n\n'
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
	echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
	sudo apt-get update
	sudo apt-get install -y mongodb-org
	sudo service mongod start
fi


# Rabitmq installation
read -p "Continue with RabbitMQ installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	echo '\n\n====== RabbitMQ instaltion =====\n\n'
	wget -O - 'https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc' | sudo apt-key add -
	echo "deb https://dl.bintray.com/rabbitmq/debian bionic main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
	sudo apt-get update
	sudo apt-get install rabbitmq-server
fi


# Cloning SkyKit project
read -p "Continue with ssh key registration? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	# This creates a new ssh key, using the provided email as a label
	ssh-keygen -t rsa -b 4096 -C "lupascugabrielcristian@gmail.com"

	# Add your SSH private key to the ssh-agent. If you created your key 
	# with a different name, or if you are adding an existing key that has a 
	# different name, replace id_rsa in the command with the name of your 
	# private key file.
	ssh-add ~/.ssh/id_rsa

	sudo apt-get install xclip
	xclip -sel clip < ~/.ssh/id_rsa.pub
	# Copies the contents of the id_rsa.pub file to your clipboard
	read -p "Add ssh key to github account(CTRL-V). Continue?" varContinue
fi


read -p "Continue with cloning? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	git clone git@github.com:jlgcon/SkyKit.git ~/Documents/SkyKit
	git checkout dev
fi


read -p "Continue with npm install? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	npm config set registry=http://repository.jlg.ro/repository/npm-jlg/
	npm install --prefix ~/Documents/SkyKit/frontend/preview-web SkyKit/frontend/preview-web/
fi


read -p "Continue with IntellijIDEA installation (Documents folder)? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	read -p 'This might not be last version or not working at all. Update script with correct download link' varContinue
	wget -P ~/Documents https://download.jetbrains.com/idea/ideaIU-2018.2.2.tar.gz
	tar -xvzf ~/Documents/ideaIU*.tar.gz -C ~/Documents
	echo 'fs.inotify.max_user_watches = 524288' | sudo tee --append /etc/sysctl.d/idea.conf
	sudo sysctl -p --system
	rm ~/Documents/ideaIU*.tar.gz
	sh ~/Documents/idea-*/bin/idea.sh
	# To start use '/usr/local/bin/idea'

	read -p 'Set JDK in project?' varContinue
	read -p 'Run Configurations ready?' varContinue
	read -p 'Test maven compile and build?' varContinue
	read -p 'Updated bada folder path in bada-api application.properties?' varContinue
fi


read -p "Continue with ng-build preview? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	pushd ~/Documents/SkyKit/frontend/preview-web
	ng build
	popd
fi


read -p "Continue with tracker login? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sensible-browser 'http://tracker.jlg.ro'
	echo -e '\nfunction tracker() { \n\tsensible-browser "http://tracker.jlg.ro"\n}' >> ~/.bashrc
fi


echo -e '\n\n====== All done! ======='


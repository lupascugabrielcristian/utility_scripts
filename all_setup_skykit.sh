# BASHRC 
read -p "Continue with updating bashrc file? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then

	echo "source ~/Documents/utility_scripts/functii_scurtaturi.sh" >> ~/.bashrc
	echo "source ~/Documents/utility_scripts/functii_erent.sh" >> ~/.bashrc
	echo "\n\n" >> ~/.bashrc
	echo "############ DOCKER ################" >> ~/.bashrc
	echo "source ~/Documents/utility_scripts/docker-functions.sh" >> ~/.bashrc
	echo "\n\n" >> ~/.bashrc
fi

# VIDEO CARD
read -p "Continue with video card installation? This will reboot after. Continue from here(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt-get install nvidia-384
	sudo reboot
fi

# NOTES
read -p "Continue with notes setup(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d ~/Documents/notes ]; then
		mkdir ~/Documents/notes
	fi

	echo "######### NOTES ########" >> ~/.bashrc
	echo "source ~/Documents/utility_scripts/notes.aliases.sh" >> ~/.bashrc
	echo "source ~/Documents/utility_scripts/functii_notes.sh" >> ~/.bashrc
	echo "\n\n" >> ~/.bashrc
fi


read -p "Continue with exercitii setup(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d ~/Documents/notes/exercitii ]; then
		mkdir ~/Documents/notes/exercitii
		mkdir ~/Documents/notes/exercitii/ts
	fi

	echo "source ~/Documents/utility_scripts/functii_exercitii.sh" >> ~/.bashrc
fi

read -p "Continue with cowntdown(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d ~/Documents/countdown ]; then
		mkdir ~/Documents/countdown
	fi

	cp ./countdown.py ~/Documents/countdown
	cp ./tasks ~/Documents/countdown
fi

read -p "Continue with ASUS monitor installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sensible-browser 'http://www.displaylink.com/downloads/file?id=1261' #1123
	read -p "Download driver in ~/Downloads folder then press to continue" varContinue
	mv ~/Downloads/DisplayLink* ~/Downloads/assus_driver.zip
	unzip $( find ~/Downloads -name assus_driver.zip ) -d ~/Downloads/ASSUS_DRIVER
	chmod +x ~/Downloads/ASSUS_DRIVER/displaylink*.run
	~/Downloads/ASSUS_DRIVER/displaylink-driver*.run --keep --noexec
	read -p "Update detect_distro function" varContinue
	vi displaylink-driver*/displaylink-installer.sh
	sensible-browser 'https://askubuntu.com/questions/744364/displaylink-asus-mb168b-issues' &
	sudo ./displaylink-installer.sh install

	# Sa verific si asta daca merge
	# https://support.displaylink.com/forums/287786-displaylink-feature-suggestions/suggestions/7988955-support-linux-on-all-your-devices
	# https://www.alteeve.com/w/ASUS_MB169B%2B_on_Fedora_27
fi

read -p "Continue with JDK installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt install openjdk-8-jdk
fi

read -p "Continue with git, node, npm, tsc and angular-cli installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt-get install xclip # comanda pentru a copia in clipboard: pwd | xclip -sel clip
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
	sudo apt-get install elvish # interactive terminal language
	sudo apt-get install dia
	sudo apt install tilix # Terminal simulator
	sudo apt install tldr # Easy to understand man pages

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
	sudo apt install gnome-tweak-tool
	sudo apt install iftop
	sudo apt install slurm
	sudo apt install glances
	sudo apt install vifm 						# terminal file manager with vim keybindings
	sudo apt install w3m 						# terminal browser
	sudo apt install trash-cli 					# sends files to trash
	sudo snap install --classic heroku
	echo "Comenzile pentru network monitors sunt in fisierul comenzi"

	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install # For keybingings https://github.com/junegunn/fzf
fi

# GIT Configuration
read -p "Continue with GIT configuration? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	git config --global user.name "Lupascu Gabriel Cristian"
	git config --global user.email "lupascugabrielcristian@gmail.com"
fi

# VIM Configuration
read -p "Continue with VIM configuration? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	git clone https://github.com/zxqfl/tabnine-vim # This is for autocomplete plugin TabNine

	if [ ! -d ~/.config/nvim ]; then
		sudo mkdir ~/.config/nvim/
	fi
	cat ./configurari_vim.vim > ~/.config/nvim/init.vim

	if [  -d /usr/share/nvim/runtime/syntax ]; then
		sudo cp ./typescript.vim /usr/share/nvim/runtime/syntax/typescript.vim
	else
		echo "Need to have this folder in place: /usr/share/nvim/runtime/syntax"
		echo "Probably instalation changed"
	fi
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
	eval `ssh-agent -s`
	ssh-add ~/.ssh/id_rsa

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


# JETBRAINS INTELLIJ IDEA 
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
	
	cp jetbrains-idea.desktop ~/.local/share/applications/jetbrains-idea.desktop # This is to add favorites icon
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


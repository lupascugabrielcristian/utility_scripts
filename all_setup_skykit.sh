#if [ -n "$HOME_FOLDER" ]
#then
#	echo "HOME_FOLDER environment variable is set"
#else
#	echo "Before running this script run 'export HOME_FOLDER=/home/cristi/'"
#	exit 1
#fi

HOME_FOLDER=$1
read -p "HOME_FOLDER variable is $HOME_FOLDER?(yes/no)" userResponse
if [ "$userResponse" != 'yes' ]; then
	echo "Set first parameter"
	exit 1
fi

echo "[+] Current working directory: $PWD"


#read -p "Runing in docker? (yes/no)" userResponse
#if [ "$userResponse" = 'yes' ]; then
#	sudoParameter=""
#fi

# BASHRC 
read -p "Continue with updating bashrc file? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then

	echo "\n############ SCURTATURI ################" >> ~/.bashrc
	echo "source $PWD/functii_scurtaturi.sh" >> ~/.bashrc

	echo "\n############ SWAP ################" >> ~/.bashrc
	echo "source $PWD/functii_erent.sh" >> ~/.bashrc

	echo "\nexport EDITOR='nvim'\n" >> ~/.bashrc
fi


# VIDEO CARD
read -p "Continue with video card installation? This will reboot after. Continue from here(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt-get install nvidia-384
	sudo reboot
fi

read -p "Continue with exercitii setup(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d ~/Documents/exercises ]; then
		mkdir ~/Documents/exercises
	fi
	mkdir ~/Documents/exercises/angular
	mkdir ~/Documents/exercises/css
	mkdir ~/Documents/exercises/python
	mkdir ~/Documents/exercises/typescript
	cp ./new_project_scripts/new_project_css.sh ~/Documents/exercises/css/new_project.sh
	cp ./new_project_scripts/require/ ~/Documents/exercises/css/
	cp ./new_project_scripts/new_project_angular.sh ~/Documents/exercises/angular/new_project.sh
	cp ./new_project_scripts/new_project_typescript.sh ~/Documents/exercises/typescript/new_project.sh
	cp ./new_project_scripts/tsconfig.json ~/Documents/exercises/typescript/tsconfig.json

	echo "source ~/Documents/utility_scripts/functii_exercitii.sh" >> ~/.bashrc
fi

read -p "Continue with cowntdown(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d /home/cristi/Documents/countdown ]; then
		mkdir /home/cristi/Documents/countdown
	fi

	cp ./countdown.py /home/cristi/Documents/countdown
	cp ./tasks /home/cristi/Documents/countdown
fi

read -p "Continue with ASUS monitor installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sensible-browser 'https://www.displaylink.com/downloads/ubuntu' #1123
	read -p "Download latest driver in ~/Downloads folder then press to continue" varContinue
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
	sudo apt install openjdk-8-jdk -y
fi

general_package_install() {
	read -p "Continue with all required dependencies installation? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		sudo apt-get update
		sudo apt-get install xclip -y # comanda pentru a copia in clipboard: pwd | xclip -sel clip
		sudo apt-get install tsc -y
		sudo apt-get install git -y
		#sudo apt-get install nodejs -y
		#sudo apt-get install npm -y
		sudo apt-get install node-typescript -y
		#sudo npm install -g @angular/cli -y
		sudo apt-get install software-properties-common -y
		sudo apt-get install htop -y
		sudo apt-get install synaptic -y
		sudo snap install slack --classic -y
		sudo apt-get install curl -y
		sudo apt-get install bmon -y
		sudo apt-get install graphviz -y
		#sudo apt-get install elvish # interactive terminal language
		sudo apt-get install dia -y
		#sudo apt install tilix # Terminal
		sudo apt-get install tldr -y # Easy to understand man pages
		sudo apt-get install python3 -y
		sudo apt-get install gnome-tweak-tool -y
		sudo apt-get install iftop -y
		sudo apt-get install slurm -y					# network monitor
		sudo apt-get install glances -y 				# complex system monitor
		sudo apt-get install vifm -y 					# terminal file manager with vim keybindings
		sudo apt-get install w3m -y 					# terminal browser
		#sudo apt-get install torsocks					# to browse to onion sites
		sudo apt-get install trash-cli 					# sends files to trash
		sudo apt-get install zathura zathura-djvu zathura-ps zathura-cb # pdf reader with vim-like key bindings
		#sudo snap install --classic heroku
		echo "Comenzile pentru network monitors sunt in fisierul comenzi"
		sudo apt-get install qutebrowser -y		# browser like vim
		sudo apt-get install httpie -y		# testing http calls in terminal
		sudo apt-get install buku -y			# bookmark manager
		sudo apt-get install cherrytree -y 	 	# text notes in tree form
		sudo apt-get install tmux -y			# better terminal emulator thats starts in a terminal
		sudo apt-get install nmon -y 			# system monitor with network cpu, memory and processes

		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install # For keybingings https://github.com/junegunn/fzf

		sudo apt-add-repository ppa:neovim-ppa/stable
		sudo apt-get update
		sudo apt-get install neovim -y

		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
		echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
		sudo apt-get update
		sudo apt-get install google-chrome-stable -y

		sudo add-apt-repository ppa:regolith-linux/release
		sudo apt install regolith-desktop

	fi
}

general_package_install

# DOCKER
read -p "Continue with docker?(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudo apt install apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	sudo apt update
	apt-cache policy docker-ce
	sudo apt install docker-ce
	sudo systemctl status docker
	read -p "Is docker deamon started?"
fi

# Mongo installation
read -p "Continue with MongoDB installation? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	sudoParameter="yes"
	read -p "Runing in docker? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		sudoParameter=""
	fi
	echo '\n\n====== Mongo instaltion =====\n\n'
	$sudoParameter apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
	echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | $sudoParameter tee /etc/apt/sources.list.d/mongodb-org-4.0.list
	$sudoParameter apt-get update
	$sudoParameter apt-get install -y mongodb-org
	$sudoParameter mkdir /data/
	$sudoParameter mkdir /data/db
	$sudoParameter systemctl enable mongod
	if [ "$userResponse" = 'yes' ]; then
		mongod &
	else
		$sudoParameter service mongod start
	fi

	mongoimport --db notes_database --collection notes_collection --file notes_database.mongoexport
fi

# NOTES
read -p "Continue with notes setup(yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	if [ ! -d $HOME_FOLDER/Documents/notes ]; then
		mkdir $HOME_FOLDER/Documents/notes
	fi

	if [ ! -d $HOME_FOLDER/Documents/Books ]; then
		mkdir $HOME_FOLDER/Documents/Books
	fi

	pip3 install virtualenv
	cd mongo_notes/
	python3.6 -m venv env
	source env/bin/activate
	pip install pymongo
	deactivate

	echo -e "\n######### NOTES ########" >> ~/.bashrc
	echo "\nsource $PWD/functii_notes.sh" >> ~/.bashrc
fi

# VIM Configuration
read -p "Continue with VIM configuration? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	# This is for autocomplete plugin TabNine. Replace path with the clone location
	git clone https://github.com/zxqfl/tabnine-vim
	echo "set rtp+=/home/cristi/Documents/utility_scripts/tabnine-vim"

	# Kuroi color scheme
	$sudoParameter mkdir ~/.config/nvim/colors
	wget https://github.com/aonemd/kuroi.vim/archive/master.zip
	unzip kuroi.vim-master.zip
	cp kuroi.vim-master/colors/kuroi.vim ~/.config/nvim/color/

	if [ ! -d ~/.config/nvim ]; then
		sudo mkdir ~/.config/nvim/
	fi

	if [ ! -d ~/.local/share/nvim/site ]; then
		mkdir ~/.local/share/nvim/site/
	fi

	if [ ! -d ~/.local/share/nvim/site/plugin ]; then
		mkdir ~/.local/share/nvim/site/plugin/
	fi

	cp ./vim-plugins/grep-operator.vim ~/.local/share/nvim/site/plugin/grep-operator.vim
	cat ./configurari_vim.vim > ~/.config/nvim/init.vim

	if [  -d /usr/share/nvim/runtime/syntax ]; then
		sudo cp ./typescript.vim /usr/share/nvim/runtime/syntax/typescript.vim
	else
		echo "Need to have this folder in place: /usr/share/nvim/runtime/syntax"
		echo "Probably instalation changed"
	fi

	# This part is for denite plugin
	# Documentation
	# https://github.com/Shougo/denite.nvim/blob/master/doc/denite.txt
	wget https://github.com/Shougo/denite.nvim/archive/master.zip -O denite.zip
	unzip denite.zip
	$sudoParameter cp -R denite.nvim-master/* /home/cristi/.config/nvim/
	rm denite.zip
	rm -R denite.nvim-master

	git clone https://github.com/vifm/vifm-colors ~/.config/vifm/colors

	#VIFM Configuration
	# the config file is at ~/.config/vifm
	# Add 
	#		\ {Open with vim}
	#		\ vim %f,
	# at the web section for filextype
	# set the default color scheme in ~/.config/vifm/vifmrc
fi


# Tmux configuration file
cp configurations/tmux.conf $HOME_FOLDER/.tmux.conf

read -p "Continue with ssh key registration? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then
	git config --global user.name "Lupascu Gabriel Cristian"
	git config --global user.email "lupascugabrielcristian@gmail.com"

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

echo -e '\n\n====== All done! ======='

check_bashrc_configuration() {
	if grep "functii_scurtaturi.sh" ~/.bashrc 1> /dev/null 
	then
		echo "[+] Functii scurtaturi added"
	fi
}

validations() {
	check_bashrc_configuration 
}

validations

if [ $(id -u) != "0" ]
then
	echo "Need to run the script as root"
	exit 1
fi

echo "[?] HOME_FOLDER: "
read HOME_FOLDER

echo "[+] Current working directory: $PWD"
echo "[?] User name: "
read USERNAME


#read -p "Runing in docker? (yes/no)" userResponse
#if [ "$userResponse" = 'yes' ]; then
#	sudoParameter=""
#fi

prepare_directories() {
	mkdir $HOME_FOLDER/apps 
	mkdir $HOME_FOLDER/projects
}

bashrc() {
	read -p "Continue with updating bashrc file? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		echo "\n############ SCURTATURI ################" >> $HOME_FOLDER/.bashrc
		echo "source $PWD/functii_scurtaturi.sh" >> $HOME_FOLDER/.bashrc

		echo "\n############ SWAP ################" >> $HOME_FOLDER/.bashrc
		echo "source $PWD/functii_erent.sh" >> $HOME_FOLDER/.bashrc

		echo "\nexport EDITOR='nvim'\n" >> $HOME_FOLDER/.bashrc
	fi
}

video_card() {
	# VIDEO CARD
	read -p "Continue with video card installation? This will reboot after. Continue from here(yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		sudo apt-get install nvidia-384
		sudo reboot
	fi
}

exercitii() {
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
}

countdown() {
	read -p "Continue with cowntdown(yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		if [ ! -d /home/cristi/Documents/countdown ]; then
			mkdir /home/cristi/Documents/countdown
		fi

		cp ./countdown.py /home/cristi/Documents/countdown
		cp ./tasks /home/cristi/Documents/countdown
	fi
}

ASUS_monitor() {
	read -p "Continue with ASUS monitor installation? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		sensible-browser 'https://www.displaylink.com/downloads/ubuntu' #1123
		read -p "Download latest driver in ~/Downloads folder then press to continue" varContinue
		mv ~/Downloads/DisplayLink* ~/Downloads/assus_driver.zip
		unzip $( find ~/Downloads -name assus_driver.zip ) -d ~/Downloads/ASSUS_DRIVER
		chmod a+x ~/Downloads/ASSUS_DRIVER/displaylink*.run
		~/Downloads/ASSUS_DRIVER/displaylink-driver*.run
	fi
}

JDK() {
	read -p "Continue with JDK installation? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		sudo apt install openjdk-8-jdk -y
	fi
}


general_package_install() {
	read -p "Continue with all required dependencies installation? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		apt-get update
		apt-get install xclip -y 					# comanda pentru a copia in clipboard: pwd | xclip -sel clip
		apt-get install git -y
		#apt-get install nodejs -y
		#apt-get install npm -y
		#apt-get install node-typescript -y
		#npm install -g @angular/cli -y
		apt-get install software-properties-common -y
		apt-get install htop -y
		apt-get install synaptic -y
		apt-get install curl -y
		apt-get install bmon -y
		apt-get install graphviz -y
		#apt-get install elvish 					# interactive terminal language
		apt-get install dia -y
		#apt install tilix 						# Terminal
		apt-get install tldr -y 					# Easy to understand man pages
		apt-get install python3 -y
		apt-get install gnome-tweak-tool -y
		apt-get install iftop -y
		apt-get install slurm -y					# network monitor
		apt-get install glances -y 					# complex system monitor
		apt-get install vifm -y 					# terminal file manager with vim keybindings
		apt-get install w3m -y 						# terminal browser
		#apt-get install torsocks					# to browse to onion sites
		apt-get install trash-cli 					# sends files to trash
		apt-get install zathura zathura-djvu zathura-ps zathura-cb # pdf reader with vim-like key bindings
		echo "Comenzile pentru network monitors sunt in fisierul comenzi"
		apt-get install qutebrowser -y		# browser like vim
		apt-get install httpie -y		# testing http calls in terminal
		apt-get install buku -y			# bookmark manager
		apt-get install cherrytree -y 	 	# text notes in tree form
		apt-get install tmux -y			# better terminal emulator thats starts in a terminal
		apt-get install nmon -y 		# system monitor with network cpu, memory and processes
		apt-get install neovim -y

		# fzf
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install # For keybingings https://github.com/junegunn/fzf

		# Chrome
		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
		echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
		apt-get update
		apt-get install google-chrome-stable -y

		# Regolith
		add-apt-repository ppa:regolith-linux/release
		apt install regolith-desktop -y

		snap install slack --classic
		#snap install --classic heroku

		# TreeSheets
		wget http://strlen.com/treesheets/treesheets_linux64.tar.gz
		tar -xvzf treesheets_linux64.tar.gz -C $HOME_FOLDER/apps/
		rm treesheets_linux64.tar.gz 
	fi
}

docker() {
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
}

mongo() {
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
}

notes() {
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
}

vim_configuration() {
	# VIM Configuration
	read -p "Continue with VIM configuration? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		if [ ! -d $HOME_FOLDER/.config/nvim ]; then
			mkdir $HOME_FOLDER/.config/nvim/
		fi

		if [ ! -d $HOME_FOLDER/.local/share/nvim/site ]; then
			mkdir $HOME_FOLDER/.local/share/nvim/site/
		fi

		if [ ! -d $HOME_FOLDER/.local/share/nvim/site/plugin ]; then
			mkdir $HOME_FOLDER/.local/share/nvim/site/plugin/
		fi

		cp ./vim-plugins/grep-operator.vim $HOME_FOLDER/.local/share/nvim/site/plugin/grep-operator.vim
		cat ./configurations/configurari_vim.vim > $HOME_FOLDER/.config/nvim/init.vim
		# nu sunt sigur daca este nevoie de asta
		#chown $USERNAME:$USERNAME $HOME_FOLDER/.config/nvim/init.vim

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
		cp -R denite.nvim-master/* $HOME_FOLDER/.config/nvim/
		rm denite.zip
		rm -R denite.nvim-master
		
		## This is for multiple color themes
		git clone https://github.com/vifm/vifm-colors $HOME_FOLDER/.config/vifm/colors

		# This is for autocomplete plugin TabNine. Replace path with the clone location
		git clone https://github.com/zxqfl/tabnine-vim $HOME_FOLDER/.local/share/nvim/site/plugin/tabnine
		echo -e "\nset rtp+=$HOME_FOLDER/.local/share/nvim/site/plugin/tabnine/tabnine-vim" >> $HOME_FOLDER/.config/nvim/init.vim # Add 'set rtp+=[path_to]/tabnine-vim' to your .vimrc

		# Kuroi color scheme
		mkdir $HOME_FOLDER/.config/nvim/colors
		wget https://github.com/aonemd/kuroi.vim/archive/master.zip
		unzip master.zip
		cp kuroi.vim-master/colors/kuroi.vim $HOME_FOLDER/.config/nvim/colors/
		rm master.zip
		rm -rf kuroi.vim-master/

		# Vimwiki
		curl -fLo $HOME_FOLDER/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		sudo mkdir $HOME_FOLDER/.config/nvim/plugged
		chown $USERNAME:$USERNAME $HOME_FOLDER~/.config/nvim/plugged
		echo "Open nvim and run :PlugInstall and :UpdateRemotePlugins commands to complete"
	fi
}

# Tmux configuration file
tmux_configuration() {
	cp configurations/tmux.conf $HOME_FOLDER/.tmux.conf
}

ssh_key_registration(){
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
}

ide() {
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
}

protonvpn_install() {
	read -p "Continue with protonvpn installation? (yes/no)" userResponse
	if [ "$userResponse" = 'yes' ]; then
		apt install -y openvpn dialog python3-pip python3-setuptools
		pip3 install protonvpn-cli
		sudo protonvpn init
	fi
}

system_configurations() {
	xdg-settings set default-web-browser firefox.desktop
}

check_proton_vpn() {
	if [[ $(protonvpn -v) =~ "ProtonVPN-CLI" ]]; then
		echo "[+] ProtonVPN OK"
	else
		echo "[-] ProtonVPN FAILED"
	fi
}

check_bashrc_configuration() {
	if grep "functii_scurtaturi.sh" ~/.bashrc 1> /dev/null 
	then
		echo "[+] Functii scurtaturi added"
	fi
}

validations() {
	check_bashrc_configuration 
	check_proton_vpn
}

prepare_directories
bashrc
video_card
exercitii
countdown
ASUS_monitor
JDK
general_package_install
docker
mongo 
notes
vim_configuration
tmux_configuration
ssh_key_registration
ide
protonvpn_install
echo -e '\n\n====== All done! ======='
validations

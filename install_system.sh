# # Verific sa fie rulat cu sudo
# if [ $(id -u) != "0" ]
# then
# 	echo "Need to run the script as root"
# 	exit 1
# fi

echo "[+] Current working directory: $PWD"
#echo "[?] HOME_FOLDER: "
#read HOME_FOLDER

read -p "[?] User name: " USERNAME

HOME_FOLDER=/home/$USERNAME
read -p "[?] HOME_FOLDER: "$HOME_FOLDER userResponse


#read -p "Runing in docker? (yes/no)" userResponse
#if [ "$userResponse" = 'yes' ]; then
#	sudoParameter=""
#fi

prepare_directories() {
	mkdir $HOME_FOLDER/apps 
	mkdir $HOME_FOLDER/projects
	mkdir -p $HOME_FOLDER/Documents/research
	mkdir -p $HOME_FOLDER/Documents/tools

	# Fac sa apartina userului ca sa poata modifica cowntdown.task
	sudo chown -R $USERNAME:$USERNAME $PWD
	sudo chown -R $USERNAME:$USERNAME $HOME_FOLDER/Documents/tools
	sudo chown -R $USERNAME:$USERNAME $HOME_FOLDER/apps

	# Pentru all_time_scripts
	mkdir -p $HOME_FOLDER/Documents/research/all_the_time_scrips
	touch $HOME_FOLDER/Documents/research/all_the_time_scrips/all_the_time_sources.sh

	sudo apt update

	echo "Directories ready"
}

bashrc() {
	echo ""
	read -p "Continue with updating bashrc file? (y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		# Pun variabila LOCATION_OF_UTILITIES_FOLDER in .bashrc pentru a o folosi dupa aceea in fisierele functii_*.sh
		echo "" >> $HOME_FOLDER/.bashrc
		echo "export LOCATION_OF_UTILITIES_FOLDER=$PWD" >> $HOME_FOLDER/.bashrc
		echo "export LOCATION_OF_VIMWIKI=$HOME_FOLDER/vimwiki" >> $HOME_FOLDER/.bashrc
		echo "export LOCATION_OF_RESEARCH_FOLDER=$HOME_FOLDER/Documents/research" >> $HOME_FOLDER/.bashrc
		echo "export LOCATION_OF_TOOLS_FOLDER=$HOME_FOLDER/Documents/tools" >> $HOME_FOLDER/.bashrc
		echo "export LOCATION_OF_KEEP=$HOME_FOLDER" >> $HOME_FOLDER/.bashrc
		echo "" >> $HOME_FOLDER/.bashrc

		echo "" >> $HOME_FOLDER/.bashrc
		echo "############ SCURTATURI ################" >> $HOME_FOLDER/.bashrc
		echo "source $PWD/functii_scurtaturi.sh" >> $HOME_FOLDER/.bashrc

		echo "" >> $HOME_FOLDER/.bashrc
		echo "############ NOTES ################" >> $HOME_FOLDER/.bashrc
		echo "source $PWD/functii_notes.sh" >> $HOME_FOLDER/.bashrc

		echo "" >> $HOME_FOLDER/.bashrc
		echo "############ ALL TIME SCRIPTS ################" >> $HOME_FOLDER/.bashrc
		echo "source $HOME_FOLDER/Documents/research/all_the_time_scrips/all_the_time_sources.sh" >> $HOME_FOLDER/.bashrc

		echo "export EDITOR='nvim'" >> $HOME_FOLDER/.bashrc
		echo "" >> $HOME_FOLDER/.bashrc

		echo ""  >> $HOME_FOLDER/.bashrc
		echo "############ CURSOR ################" >> $HOME_FOLDER/.bashrc
		echo "#export PS1=\"\$BBLE \W $ \$RS \" # Activate this after testing" >> $HOME_FOLDER/.bashrc
		echo "export PS1=\"\$BMAG \W $ \$RS \"  # For docker testing" >> $HOME_FOLDER/.bashrc
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
	echo ""
	read -p "Continue with all required dependencies installation? (y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		sudo apt-get update
		sudo apt-get install python3.8 -y

		read -p "[!] git " userResponse
		sudo apt-get install git -y
		sudo apt-get install htop -y
		sudo apt-get install curl -y
		sudo apt-get install wget -y

		##apt-get install nodejs -y
		##apt-get install npm -y
		##apt-get install node-typescript -y
		##npm install -g @angular/cli -y
		#apt-get install synaptic -y
		#apt-get install bmon -y

		#apt-get install tldr -y 					# Easy to understand man pages
		#apt-get install python3 -y
		#apt-get install gnome-tweak-tool -y
		#apt-get install iftop -y
		#apt-get install slurm -y					# network monitor
		#apt-get install nmon -y 					# system monitor with network cpu, memory and processes

		read -p "[!] vifm " userResponse
		sudo apt-get install vifm -y 				# terminal file manager with vim keybindings
		sudo apt-get install w3m -y 				# terminal browser
		sudo apt-get install trash-cli -y			# sends files to trash
		sudo apt-get install httpie -y				# testing http calls in terminal

		read -p "[!] buku " userResponse
		sudo apt-get install buku -y			# bookmark manager
		apt-get install jq				# to parse json in terminal
		sudo apt-get install kpcli -y # local password manager

		read -p "[!] ssh and disable" userResponse
		sudo apt-get install openssh-server -y
		sudo systemctl disable sshd.service
	fi
}

auxiliary() {
	echo ""
	read -p "Continue with auxiliary installation?(y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		apt-get install graphviz -y
		sudo apt-get install dia -y 										# aici imi arata tarile
		sudo apt-get install zathura zathura-djvu zathura-ps zathura-cb -y 	# pdf reader with vim-like key bindings
		echo "Comenzile pentru network monitors sunt in fisierul comenzi"
		apt-get install qutebrowser -y										# browser like vim
		apt-get install cherrytree -y 										# text notes in tree form
		sudo apt-get install gimp inkscape -y
		sudo apt-get install chromium-browser -y

		#apt-get install torsocks											# to browse to onion sites
	fi
}

awesome_configurations() {
	echo ""
	read -p "Continue with awesome?(y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		sudo apt-get install awesome -y
		
		# Configuration files
		# Trebuie sa am fonturile Jetbrains Mono NL instalate
		sudo cp configurations/rc.lua /etc/xdg/awesome/rc.lua
		sudo cp configurations/theme.lua /usr/share/awesome/themes/default/theme.lua
	fi
}

alacrity_configuration() {
	echo ""
	read -p "Continue with alacrirry?(y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		# Alacrity GPU terminal emulator
		sudo add-apt-repository ppa:mmstick76/alacritty
		sudo apt install alacritty -y

		mkdir -p $HOME_FOLDER/.config/alacritty
		cp configurations/alacritty.yml $HOME_FOLDER/.config/alacritty/alacritty.yml
	fi
}

drawio() {
	echo ""
	read -p "Continue with drawio?(y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		read -p "Trebuie verificat pentru o noua versiune" userResponse
		sudo apt-get install wget -y
		wget https://github.com/jgraph/drawio-desktop/releases/download/v14.5.1/drawio-x86_64-14.5.1.AppImage -P $HOME_FOLDER/apps
		sudo chmod +x $HOME_FOLDER/apps/*.AppImage
		sudo ln -s $HOME_FOLDER/apps/drawio-x86_64-14.5.1.AppImage /bin/drawio
	fi
}

fzf_configuration() {
	echo ""
	read -p "Continue with fzf?(y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install # For keybingings https://github.com/junegunn/fzf 
	fi
}

docker() {
	echo ""
	read -p "Continue with docker?(y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
		  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io -y


		read -p "[!] Docker-compose"
		sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		sudo chmod +x /usr/local/bin/docker-compose
		sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

		sudo curl -L https://raw.githubusercontent.com/docker/compose/1.28.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

		sudo groupadd docker
		sudo usermod -aG docker $USERNAME
	fi
}

mongo() {
	# Mongo installation
	read -p "Continue with MongoDB installation? (y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		sudo apt-get install wget gnupg -y
		wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

		# Asta e diferit functie de varianta de Ubuntu
		# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
		echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
		sudo apt-get update
		sudo apt-get install -y mongodb-org mongodb-clients

		sudo mkdir -p /data/db
		sudo chown -R $USERNAME:$USERNAME /data/db
	fi
}

#notes() {
#	read -p "Continue with notes setup(yes/no)" userResponse
#	if [ "$userResponse" = 'yes' ]; then
#		sudo apt-get install python3.8 -y
#		if [ ! -d $HOME_FOLDER/Documents/notes ]; then
#			mkdir -p $HOME_FOLDER/Documents/notes
#		fi
#
#		if [ ! -d $HOME_FOLDER/Documents/Books ]; then
#			mkdir -p $HOME_FOLDER/Documents/Books
#		fi
#
#		echo "" >> $HOME_FOLDER/.bashrc
#		echo "######### NOTES ########" >> $HOME_FOLDER/.bashrc
#		echo "source $PWD/functii_notes.sh" >> $HOME_FOLDER/.bashrc
#	fi
#}

vim_configuration() {
	# VIM Configuration
	echo ""
	read -p "Continue with VIM configuration? (y/n)" userResponse
	if [ "$userResponse" = 'y' ]; then
		sudo apt-get install git -y
		sudo apt-get install neovim -y

		mkdir -p $HOME_FOLDER/.config/nvim/
		mkdir $HOME_FOLDER/.config/nvim/plugged
		read -p "Am facut .config/nvim" anyResponse

		if [ ! -d $HOME_FOLDER/.local/share/nvim/site/plugin ]; then
			mkdir -p $HOME_FOLDER/.local/share/nvim/site/plugin/
		fi
		read -p "Am facut plugin folder" userResponse

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

		## multiple color themes
		#git clone https://github.com/vifm/vifm-colors $HOME_FOLDER/.config/vifm/colors

		# Vimwiki
		curl -fLo $HOME_FOLDER/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		sudo chown -Rv $USERNAME:$USERNAME $HOME_FOLDER/.config/nvim/plugged
		sudo chown -Rv $USERNAME:$USERNAME $HOME_FOLDER/.config/nvim/
		sudo chown -Rv $USERNAME:$USERNAME $HOME_FOLDER/.local/share/nvim/
		read -p "Open nvim and run :PlugInstall and :UpdateRemotePlugins commands to complete" userResponse
	fi
}

# Tmux configuration file
tmux_configuration() {
	# better terminal emulator thats starts in a terminal
	sudo apt-get install tmux -y			
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
	#check_proton_vpn
}

prepare_directories
general_package_install
auxiliary
vim_configuration
bashrc
#video_card
#exercitii
#ASUS_monitor
#JDK
docker
#mongo 
fzf_configuration
tmux_configuration
awesome_configurations
alacrity_configuration
drawio
##ssh_key_registration
validations
echo ""
echo ""
echo "====== All done! ======="


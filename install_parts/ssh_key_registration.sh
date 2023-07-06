ssh_key_registration(){
	read -p "Continue with ssh key registration? (yes/no)" userResponse

	read -p "Email for ssh and git?" email
	read -p "User name for git" git_name

	if [ "$userResponse" = 'yes' ]; then
		git config --global user.name $git_name
		git config --global user.email $email

		# This creates a new ssh key, using the provided email as a label
		ssh-keygen -t rsa -b 4096 -C $email

		# Add your SSH private key to the ssh-agent. If you created your key 
		# with a different name, or if you are adding an existing key that has a 
		# different name, replace id_rsa in the command with the name of your 
		# private key file.
		eval `ssh-agent -s`
		ssh-add ~/.ssh/id_rsa

		xclip -sel clip < ~/.ssh/id_rsa.pub
		# Copies the contents of the id_rsa.pub file to your clipboard
		read -p "Add ssh key to github account(CTRL-V). Continue?" varContinue
		sensible-browser 'https://github.com/settings/keys'
	fi
}

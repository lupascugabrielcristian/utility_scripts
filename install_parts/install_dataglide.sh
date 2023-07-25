# Pull Datagrip keys. Requires that id_rsa.pub to be added to authorized keys on the server
scp -P 7131 ramonbassecharcan@165.232.117.151:./storage/dataglide_keys.zip $HOME

sudo snap install storage-explorer
sudo snap connect storage-explorer:password-manager-service :password-manager-service
sudo snap install datagrip --classic
sudo snap install chromium

# Setup chromium: parallel bookmarks, production bookmards, mail

# Setup Storage explorer: connect storage container

# Setup datagrip: connect DBs

# Setup Ruby

# Surfshark
curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh #gets the installation script
cat surfshark-install.sh #shows script's content
sh surfshark-install.sh #installs surfshark

# Git
pushd ~/projects/Dataglide/Publish.Config/
git config user.name Cristian.Lupascu@dataglide.co
git config user.email "Gabriel-Cristian Lupascu"
popd

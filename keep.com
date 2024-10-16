uname -a # os name freebsd
lsb_release # os name release
lsb_release -a # ubuntu version
cat /etc/release # os name
cat /proc/version # os name
scp file usernaem@remotehost:./Documents/research filename # scp copy from local to remote
scp gabi@192.168.1.6:/home/gabi/vimwiki/mongo_database_with_python.wiki /tmp/ # ssh copy from remote to local
scp * roow@x.x.x.x:./.. # ssh copy all files in folder
scp source-file.go root@a.b.c.d:./destination-folder # scp ssh copy file from local to remote
nmap -sT [ip] # works in most of the cases
nmap -sT [ip] -p [port] # accepta si port
nmap -pN [ip] -p [port number] # worked in the freebsd in virtual box case # 
nmap -Pn [ip] # worked for tablet after sT failed # can use also a range
nmap -sn 192.168.2.1/24 # simplest host discovery # https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network
nmap $1 -n -sP | grep report | awk '{print $5}' # bash script output IP addresses
ps aux | sed -e '1p' -e '/python/!d' # filter command output and first line
sudo nmap -sn --send-ip 192.168.2.100-200 # a mers sa descopar celalalt laptop
lsof # view open files at one moment
sudo lsof -i :631 # process for port 
lsof | grep 8082 # open file for port
sudo lsof -i -P -n | grep LISTEN # cea mai buna comanda de afisat porturile deschise
netstat -i [interface_name] # check transfer data for interface wifi speed
netstat -r # routing tables
netstat --tcp --udp --listening --programs --numeric # all listening TCP and UDP ports with the process ID and numerical addresses
netstat -tulnp # all listening TCP and UDP ports with the process ID and numerical addresses
ufw deny <port number> # deny port access through firewall rule
sudo chown -R user:user foldername/ # owner for folder
less /proc/cpuinfo # checl cpu information processor procesor
lspci -vnn | grep VGA -A 12 # gpu card information # https://www.maketecheasier.com/graphics-card-information-linux/
sudo apt install lshw-gtk # gui for hardware details
echo ifconfig=\""$some_var"\" # echo variable and double quotes
:%!jq . # reformat json file in vim nvim cool
/\cpattern # search case insensitive for pattern in nvim
csvtool readable ai_data.csv | view - #  terminal csv viewer opens default editor nvim
<leader> D # pentru a deshide Denite sa caut fisier/file in nvim/vim recursiv. Este din nnoremap, in .config/nvim/init.vim
CTRL+W  + ^ = splits vim window vertically # nvim vim window 
:set expandtab # sau :set et use spaces instead of tabs in nvim :help 'expandtab', spatii
:t. # duplicate line nvim
:set tabstop=2 # size of tabs in spaces in nvim
pwd | xclip # copy the output from pwd command to xclip
xclip -o # pastes the contents of the xclip
sudo dd bs=4M if=path-to-the-ISO of=/dev/sdX status=progress && sync # make bootable usb
exec(open("./python_def_file.py").read()) # will read the functions defined in that file and can be used in python console
sudo tshark -D  # shows all interfaces
ip link set [interface_name] Up # brings the interface up
mongo 127.0.0.1:27017/skykit < line.js # run script in mongo database
sudo !! # repeats the last command as sudo
CTRL + x + e # opens an editor to run a command
mount -t tmpfs tmpfs /mnt/ram -o size=8192M # creates a super fast ram disk # https://www.youtube.com/watch?v=Zuwa8zlfXSY&feature=youtu.be
fc # fix previous command in a text editor
ssh -L 2227:127.0.0.1:6379 root@emkc.org -N # tunnel with ssh local port 2227 -> remote host's 127.0.0.1 on port 6379
mkdir -p folder/{subfolder}/{sub1, sub2, sub3} # quiqly make subforlders
cat file | tee -a log | cat > /dev/null # intercept stdout and log to a file
set selection-clipboard clipboard # zathura copies to clipboard
CTRL + R # fzf history commands
if [ "$1" = 'c' ]; then # bash if compare strings
pip install -r /path/to/requirements.txt
python -m pip freeze # see all packages installed in the active virtualenv
justify-content: space-evenly # arrange flex items horizontally
sudo service networking restart # restarts the netwoerking services
nmcli # network manager command line interface
nmcli connection show --active # activa interfaces
nmcli d # active connections
nmcli d show enp0s31f6 # dns configurations pentru interfata
CTRL + O # vim jump to previous visited position
CTRL + I # vim jump to next visited position
:%s/CTRL+R, CTRL+A/newword/ # vim replace word under cursor with newword. CTRL+R activeaza Ex special caracters. Pot fi mai multe
CTRL+a # vim increase number under cursor
CTRL+x # vim decrease number under cursor
if [ -d /home/cristi/Documents/research/ ]; then ... else ... fi # check for directory(folder) exists bash 
date=$(date '+%Y-%m-%d') # puts date in bash variable
ls -l | wc -l # counts the number of lines in the current foleder
if [ "$#" -eq 0 ]; then # checks if number of arguments is 0 # counts
attach-session -t . -c /new/path # changes the working directory in tmux 
CTRL-b + c # creates new window in tmux  
CTRL-b + [ # scrolling tmux up down
snap refresh # updating snap packages
lscpu # list cpu processor information
cat /proc/cpuinfo # list cpu processor information
docker container exec -it container-name /bin/sh # returns a shell inside the container
for var in "$@" do echo ceva done # enumerate bash arguments
fail() { : "${__fail_fast:?$1}"; } # exit from function fast bash return
pkill -f skykit-designer-web-api # kills a process by name
docker container ls -aq # displayes the id of all containers
docker network ls -q # displays the ids of all docher networks
ng g c phone-numbers --module=../app.module # angular creates component in app diferent module
lsmod # shows loaded drivers
iw dev wlan0 link # shows wifi connectection/connected status name 
apt show [package name] # show details for a packet info
sudo apt install ./[path to file] # install package from file
docker-compose logs preview-back-end # show logs for a docker container
docker-compose -f rabbit_docker-compose.yml build preview-back-end # docker rebuild an image
ls /etc/.init.d/ # folder with running services
dhclient3 wlan0 # get an IP address from access point AP
protonvpn c --cc RO # connect to vpn proton
systemctl status snap.docker.dockerd.servce # 
systemctl restart [service name] #
systemctl list-units # services list
sudo usermod -aG docker $(whoami) # to add docker user 
nmcli devices # 
nmcli connection # shows all internet profiles
curl https://ipinfo.io/ip # get public ip
curl https://ipvigilante.com/<your ip address> # get the geolocation
ls /etc/apt/sources.list.d/ # repositories sources 
/home/cristi/Documents/projects/psutil # monitor by me python
/sys/class/backlight/intel_backlight/brightness # set the brightness terminal 
xrandr --brightenss 1.1 # set the brightness with xrandr
xrandr --output eDP-1-1 --gamma 1.1:0.78172716:0.7 --brightness 1.1 # set the color tint
xrandr --output DP-3 -scale 1.2x1.2 # scales screeen zoom out
lsmod | grep kill # lists kernel modules
dmesg -c # check kernel messages
tar -xvzf community_images.tar.gz # unzip tar.gz file
tar -xvf file.tar.bz2 # unzip tar bz2 archive file
tar -xf file.tar.xz # unzip tar.xz archive file
tar -Jxvf file.txz # unzip txz archive files
zip -sf Dataglide.zip Dataglide # zip a folder 
tar -xvzf /path/to/yourfile.tgz # tgz archive file
${#array_name} # bash length of an array list
find /path/ -name skykit_airspace.xml -exec cp '{}' . \; # find and execute command on each file bash
find / -name "*.drawio" -print 2>/dev/null # finds file with extension and ignores error message
find / -name "*ecran*" -print 2>/dev/null # finds a file with the name contains string
sudo find / -type d -name *mplayer 2> /dev/null  # search for configuration files for mplayer app
sudo update-alternatives --config x-terminal-emulator # set up terminal for regolith
medusa -d # shows the modules available
rfkill list # wireless block blocked soft hard
sudo systemctl restart NetworkManager # restarts wifi
iwlist wlp2s0 scan | grep ESSID # scans for wifi networks
CTRL + = # set terminal font size default i3wm
CTRL + '+' # set terminal font smaller i3wm
CTRL + SHIFT + '-' # sets terminal fonst larger i3wm
:19 co . # vim copy line number 19 to current position
git log --all --decorate --oneline --graph # pretty git log
git pull origin branch-i-want-to-be-identical-to # make 2 branches equal
git config user.email # setare user email 
:e! # updates current buffer vim
sudo dd bs=4M if=/path/to/ubuntu-18.04.2-desktop-amd64.iso of=/dev/sdx status=progress oflag=sync # command bootable usb create
lsblk # lists devices dev. useful command for disk creator
:!find%u # vifm populate view with all files in all subdirectories
:bmarks  # vifm shows all bookmarks
:bmark [tag] # vifm bookmark a directory location
:filter !{*.js} # vifm filter files that match a extension
:find manager* # vifm finds file starting with manager is folder under cursor
:vie[w] # vifm toggle on and off the quick view file
CTRL + w # vifm switch on/off the preview panel
:!nvim %f # in vifm open the selected file with nvim - external
:al # in vifm creates a link of file from left to right
:move # in vifm move the file to the other pane
za # show hidden files in vifm
:filetype *.xslx libreoffice %f
xdg-settings set default-web-browser firefox.desktop # set default browser
cat ~/.config/mimeapps.list # shows default applications for user
inProfit() ? "happy" : "sad"; # short version of if else java
zip -sf [file_name.zip] # look into zip file list files inside archive
df # disk space usage free
crontab -e # open user config crono, cron file, periodical task run
xrandr -s 1600x900 # change resolution from terminal
sudo tshark -i enp0s25 -f "host 134.122.86.164" -w dos_recordings.pcap # monitor packets ip destination address
sudo pacman -S $PACKAGE --overwrite '*' # archlinux solve error conflicting
pacman -Syu # upgrade all packages
acpi -V # archlinux check baterry status
iostat -c # monitor system processor 
curl cheat.sh/[name] # cheatsheet online terminal based
npm search @angluar-cli # for searching in repository for packages
sudo npm install -g @angular/cli@6.1.0 # install specific version of package
xmag # mangifier zoom screen
String[] monthsArray = list.toArray( new String[list.size()] );
sed -n '147p;147q' finename.java # cat display show only line number
upower -i /org/freedesktop/UPower/devices/battery_BAT0 # check battery status
cat /sys/class/power_supply/BAT0/capacity # battery capacity check
acpi # battery monitor status check
/usr/share/vim/vim81/colors/ # location of default vim color scheme
:g/ # displays all vim search results
sbal # comanda mea de cautat prin bookmarks, bookmark
rbal # comanda mea de deschis un bookmark
dpkg -l cups* # check if package cups* este instalat in sistem # installed, check
dpkg -L keymapper # where a package is installed
dpkg -s package-name # check status installed package
sudo apt list --installed # lists installed apt packages system
connect_monitor # comanda care am facut-o eu pentru monitorul extern care foloseste xrand
bw get item bitb | jq # bitwarden get a single item and displays json format parsed
bw list items --search ebloc --pretty # search bitwarden
xrandr --output eDP-1-1 --brightness 0.5 # brightness cu xrandr
systemctl suspend # sleep computer power
git rm --cached .idea # remove cached file folder from git repository
/sys/class/net/wlo1/statistics/rx_bytes # network transmission monitor system
C-x r m # emacs set a bookmark at cursor position
Ctrl + Shift + Space # enter alacritty vi mode
~.bash_profile # commands that run on logon
git branch -a # shows all git branches in a repository
src/app/**/*.html # visual studio code, search in file type
"editor.lineNumbers": "relative" # in visual studio sa am numar relative la linii. vim line
python -m http.server 8080 # python http server
event.stopPropagation # Stop mouse click event Angular from propagating. Pass to (click)="fucntion($event)"
[ngClass]="{'pagina-activa': currentPage == p }" # angular clasa
CTRL + F12 # intelliJ methods popup list
g++ -o check_flask_configuration check_flask_configuration.cpp	# compile c++ program
bw get item "Digital Ocean" | jq '.notes' # json pipe get value
jq '.data[0]' /tmp/apicall.json # parse json from file get data object and first element in array
echo '{"studentid": 1, "name": "ABC", "subjects": ["Python", "Data Structures"]}' | python3.10 -m json.tool # format json with python in line
echo "dafasdfasdfas asdfasdf asfdasdfasd" | awk '{split($0,result, " "); print result[2]}' # exemplu de awk spit substring string
grep -rlw "Oferim cursuri" . # search text inside files in current folder
ls | grep png$ # list files end ending in png extension
ls | grep ^screen # list files begin start in with text
:VMS # Vim wiki search /pattern/
:vimgrep /in constuctor/ **/*.ts # search vim grep in files
:copen # lista cu rezultate de la vimgrep search result
:cnext # urmatorul element in lista de rezultate de la vimgrep
:lopen # shows a list with vimwikisearch results VWS
id <user name> # details for a user, guid , groups
ps | awk '{print $1}' # first column of output
awk -F ":" '{print $1 $2\t$6}' /etc/passwd # field separator and file at the end, multiple columns
awk 'BEGIN{FS=":"; OFS="-"} {print$1,$6,$7}' /etc/passwd # output field separator change
awk -F "/" '/^\// {print $NF}' /etc/shells # with field separator /, search for pattern: line that starts with /, and print last field
awk -F "/" '/^\// {print $NF}' /etc/shells | uniq # comanda de mai sus cu filtru de elemente unice
awk -F "/" '/^\// {print $NF}' /etc/shells | uniq | sort  # aranjeaza alfabetic
df | awk '/\/dev\/loop/ {print $1"\t"$2+$3}' # sum artithmetic math with columns
awk 'length($0) < 8' /etc/shells # length of line filter
ps -ef | awk '{ if($NF == "/bin/fish") print $0}'  # conditional last field in awk if statement
awk 'BEGIN { for( i=1; i<10; i++) print "The square root of", i, "is", i*i;}'  # for loop with print text 
awk '$1 ~ /^[b,c]/ {print $0}' .bashrc # prints every line that begin with character b or c
awk '{print substr($0,4)}' numbered.txt # substring function for lines with number at the begining. ignored first 4 characters
awk 'match($0, /o/) {print $0 " has \"o\" character at " RSTART}' numbered.txt  # find lines. RSTART is position where pattern was found. Pattern is character o.
df | awk 'NR==7, NR==11 {print NR, $0}' # record number and range of lines
awk 'END {print NR}' /etc/shells # line count
awk 'END {print NR}' /etc/shells /etc/passwd # line count multiple files
{{{php # vimwiki language sintax
ln -s /full-path-to-file /usr/local/bin  # creates a soft link
free -m # memory available
vmstat -s # memory available
cat /proc/meminfo # memory available
tail -f /proc/<pid>/fd/1 # check logs for running program
column -s, -t < somefile.csv | less -#2 -N -S # view csv file in terminal 
du -h # show disk space usage folder size 
str.zfill( width ) # python padding 0
java -cp /dev/myap.jar:/dev/dependency.jar com.codementor.MyApp # run a java application from command line with classpath with multiple jars
someString.codePointCount(0, someString.length()) # counts the number of characters in a string  code points BMP BasicMultilingual Plane U+10000 
someString.codePoints().count() # counts the number of characters in a string  code points BMP BasicMultilingual Plane U+10000  Java 8
gsettings describe org.gnome.desktop.... # to understande options in teriman for Settings manager
gsettings set org.gnome.desktop.screensaver lock-enabled false
tldr # easy to understande man pages command
ffuf # cyber automated content discovery
dirb # cyber automated content discovery
gobuster # cyber automated content discovery
w # command shows all users who are logged on the system and what they are doing
stat file.txt # shows last modified date of this file
touch file.txt -d "1 month ago" # change the modified date of a file
touch -t 09082002 AMMMANAGEMENT\&SUPORTSIMOBILESRL.pdf # changes to a older date in android with adb
gg=G # reformat all file in vim
xsv split -s 1500 --filename "HP_Link_Group_{}.csv" HP_LINK_GROUP HP_Link\ Group.csv # split file
xset dpms 100 0 0 # set power management display timeout to 100 seconds
xset dpms 0 0 0 # disable display timeout
xset s off # disable screensaver
xset -q # show power management settings
gsettings set org.gnome.desktop.interface color-scheme prefer-light # light, bright theme
gsettings set org.gnome.desktop.interface color-scheme prefer-dark # dark, black theme
CTRL + ALT + SHIFT + N # finds function name in a file IntelliJ IDE Jetbrains Android Studio

# Pages
ssh-chat # https://www.tecmint.com/ssh-chat-linux-terminal-chat-client/
fzf # https://github.com/junegunn/fzf # documentation for fzf
https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes # docker remove images
https://askubuntu.com/questions/732985/force-update-from-unsigned-repository # fix not trusted repository
https://github.com/regolith-linux/regolith-desktop/wiki/Getting-Started # regolith terminal commands keys
https://account.live.com/names/Manage?mkt=en-US&refd=account.microsoft.com&refp=profile&uaid=8b27e35e1a8f47fcac856b7667bb2de5 # add alias
https://i3wm.org/docs/userguide.html # i3 documentation
https://www.linuxbabe.com/command-line/ubuntu-server-16-04-wifi-wpa-supplicant # wpa_suplicant
https://man.finalrewind.org/1/feh/ # images preview
https://hackaday.com/2022/01/19/make-your-python-cli-tools-pop-with-rich/ # python rich library
https://windowjs.org/ # window.js
https://hackaday.com/2022/01/17/hack-the-web-without-a-browser/ # woob Web Without A Browser
https://res.cloudinary.com/practicaldev/image/fetch/s--Zib71Fgv--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/n082uxea33j6zq3mca7u.png # git cheetsheet
https://codeshare.io/loDAny # live code share online
https://untools.co/ # tools for better thinking
https://www.grc.com/port_2869.htm 	# ports vulnerability profiling
https://vuldb.com/?search # ports vulnerability profiling
https://www.cvedetails.com/ # ports vulnerability profiling 

# Packages
iptraf-ng # network monitor
fuser # identify processes using files and sockets
nmon # monitor system general memory processor
Documents/projects/chess-terminal/sunfish # terminal chess
alsamixer # to start sound in terminal
feh # a highly customizable imageviewer that can also set a desktop background pictures images view
fzy # fuzzy search that works with nvim, neovim
mupdf # pdf reader documents
jq # parse json in terminal
okular # document epub edit
scribus # edit pdf editor
treesheets # hieratchical notes
jq # pipe bash command to json
remind # linux package notification apt desktop
from rich.console import Console # python library design
window.js # open-source Javascript runtime for desktop graphics programming
gpick # color picker
alsamixer # audio speaker microphone mic sound
sqlitebrowser # ui interface db sqlite
broot # better tree file manager rust
lsd # fancy ls

# Dorks
inurl:ro # site-uri doar romanesti

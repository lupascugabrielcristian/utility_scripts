alias cdsk='cd ~/Documents/SkyKit/'
alias cdex='cd ~/Documents/exercises/skykitStart/'

kpreview() { 
	echo "Opening chrome in kiosk mode at http://localhost/map/$1" 
	google-chrome --kiosk --auto-open-devtools-for-tabs "http://localhost/map/$1" 
}

preview() {
	echo "Opening chrome at http://localhost/map/$1" 
	google-chrome --auto-open-devtools-for-tabs "http://localhost/map/$1" 
}


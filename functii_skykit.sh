kpreview() { 
	echo "Opening chrome in kiosk mode at http://localhost/map/$1" 
	google-chrome --kiosk --auto-open-devtools-for-tabs "http://localhost/map/$1" 
}

preview() {
	if [ "$#" -eq 0 ]; then
		echo "Need id for scenario"
		return 1
	fi
	echo "Opening chrome at http://localhost:4200/map/$1" 
	google-chrome --auto-open-devtools-for-tabs "http://localhost:4200/map/$1" 
}

firefoxdev1() {
	~/Downloads/firefox-69.0b12/firefox/firefox -devtools http://localhost:4201
}

firefoxdev3() { 
	~/Downloads/firefox-69.0b12/firefox/firefox -devtools http://localhost:4203 
}

sk-flight-generator() {
	~/Downloads/firefox-69.0b12/firefox/firefox http://localhost:4201 &
	cd ~/Documents/SkyKit/frontend/flights-generator-web/
	ng s
}

fd() {
	~/Downloads/firefox-69.0b12/firefox/firefox -devtools http://localhost:$1/$2
}

md() {
	midori -a http://localhost:$1
}

help_functii_scurtaturi() {
	echo "kpreview - opens the chrome browser with devel open" 
	echo "firefoxdev1 - the other firefox at localhost:4201" 
	echo "firefoxdev3 - the other firefox at localhost:4203" 
	echo "fd [port number] - the other fireofx at localhost:port you entered"
}

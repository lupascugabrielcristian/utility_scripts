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


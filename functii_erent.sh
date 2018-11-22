# =============== ERENT ==================

function erent() { 
	if [ "$1" == "local" ]; then
		google-chrome --auto-open-devtools-for-tabs "http://localhost:4200/"  
	elif [ "$1" == "heroku" ]; then
		google-chrome "https://eurent-app.herokuapp.com/"  
	elif [ "$1" == "herokulocal" ]; then
		google-chrome "http://localhost:5000/hi"
	else
		echo "Variante: local heroku herokulocal"
	fi
}

# ========================================

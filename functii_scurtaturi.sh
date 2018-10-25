function w3m-google() {
	googleSearchPage="https://www.google.com/search?client=ubuntu&channel=fs&q="
	all=""
	all="$*"
	searchString=""
	for word in $all; do
		searchString=$searchString+$word
	done
	searchString=${searchString:1}
	echo Searching for $searchString
	w3m $googleSearchPage$searchString
}

function search-google() {
	googleSearchPage="https://www.google.com/search?client=ubuntu&channel=fs&q="
	all=""
	all="$*"
	searchString=""
	for word in $all; do
		searchString=$searchString+$word
	done
	searchString=${searchString:1}
	echo Searching for $searchString
	sensible-browser $googleSearchPage$searchString
}

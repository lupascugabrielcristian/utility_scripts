# LOCATION_OF_RESEARCH_FOLDER este locatia folderului research. Este fara ultima /
# Este facuta de install_system.sh si exportat in .bashrc

# check for all_the_time folder or make it
if [ -d $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/ ]; then
	echo "[+] All_the_time folder found"
else 
	mkdir $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips
	echo "[!] All_the_time folder created"
fi

# get date
date=$(date '+%Y-%m-%d')

# check for date folder or make it
if [ -d $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/$date ]; then
	echo "[+] Today folder found"
else 
	mkdir $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/$date
	echo "[!] Today folder created: $date"
fi

counter=$(ls -l $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/$date/ | wc -l)

# create script file
if [ "$#" -eq 0 ]; then
	file_name=$counter\_$date.sh
else 
	file_name=$counter\_$date-$1.sh
fi
echo [+] Name will be $file_name
touch $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/$date/$file_name

# add line in research/all_the_time_sources.sh source the new file
echo source $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/$date/$file_name >> $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/all_the_time_sources.sh

nvim $LOCATION_OF_RESEARCH_FOLDER/all_the_time_scrips/$date/$file_name

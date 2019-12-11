base_path=/home/cristi/Documents

# check for research folder or make it
if [ -d $base_path/research/ ]; then
	echo "[+] Research folder found"
else 
	mkdir $base_path/research
	echo "[!] Research folder created"
fi

# check for all_the_time folder or make it
if [ -d $base_path/research/all_the_time_scrips/ ]; then
	echo "[+] All_the_time folder found"
else 
	mkdir $base_path/research/all_the_time_scrips
	echo "[!] All_the_time folder created"
fi

# get date
date=$(date '+%Y-%m-%d')

# check for date folder or make it
if [ -d $base_path/research/all_the_time_scrips/$date ]; then
	echo "[+] Today folder found"
else 
	mkdir $base_path/research/all_the_time_scrips/$date
	echo "[!] Today folder created: $date"
fi

counter=$(ls -l $base_path/research/all_the_time_scrips/$date/ | wc -l)

# create script file
if [ "$#" -eq 0 ]; then
	file_name=$counter\_$date.sh
else 
	file_name=$counter\_$date-$1.sh
fi
echo [+] Name will be $file_name
touch $base_path/research/all_the_time_scrips/$date/$file_name

# add line in research/all_the_time_sources.sh source the new file
echo source $base_path/research/all_the_time_scrips/$date/$file_name >> $base_path/research/all_the_time_scrips/all_the_time_sources.sh

nvim $base_path/research/all_the_time_scrips/$date/$file_name

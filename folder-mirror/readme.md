Readme copiat din folderul proiectului folder-mirror
This will make a rough image of a folder structure, export it to a XML file and on request read from that XML file and recreate at a specified location the same folder structure

Update rustup
$rustup update$

Compile
$cargo build --release$

Run
$./folder-mirror ~/projects/$

Build Docker image
$docker build -t folder-sync .$

Run built Docker container
$docker run -it folder-sync$

Proces
1. Generate output.xml file that contains the target folder structure
$./folder-mirror ~/projects/$
2. Run docker container to regenerate same folder structure inside the container at /tmp/ location
$docker run -it folder-sync$
3. Copy output.xml to ~/projects/
$cp output.xml ~/projects/utility_scripts/day-end/folder-mirror/folder-mirror.xml$



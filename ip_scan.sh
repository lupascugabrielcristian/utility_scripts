# How to use:
#
# /tmp/ips este un fisier care contine o lista de ip-uri
# fiecare linie contine un ip in format 192.168.1.226

while IFS= read -r line; do
	# Printeaza cu variabila
	# printf 'ping -c2 %s\n' "$line"

	# Ping pentru fiecare IP
	ping -c2 $line
done < /tmp/ips


while IFS= read -r line; do
	# Ping pentru fiecare IP
	sudo nmap -O $line
done < /tmp/ips

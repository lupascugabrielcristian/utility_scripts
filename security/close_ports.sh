sudo netstat -lnp | grep TabNine
echo "Look for pid/name"
echo "Kill pid no?__"
read portno

kill -9 $portno

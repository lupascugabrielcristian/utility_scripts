if [ -f /tmp/prolog-wiki.pl ]; then
	rm /tmp/prolog-wiki.pl
fi
touch /tmp/prolog-wiki.pl
/usr/bin/python3.10 ~/projects/utility_scripts/prolog-knowledge-base/merge-prolog-wiki.py
swipl -s /tmp/prolog-wiki.pl

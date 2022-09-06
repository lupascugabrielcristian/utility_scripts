echo "Am facut rc.local din root crontab" > /tmp/a.mers
awk '{sub("127.0.0.53",  "192.168.1.1" ); print $0 }' /etc/resolv.conf | tee -i /etc/resolv.conf
/home/alex/projects/utility_scripts/setup_monitors.sh

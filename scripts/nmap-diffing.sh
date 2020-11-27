#!/bin/bash

ip=127.0.0.1
SUBJECT="DIFF NMAP CHANGE FOR $ip"
TO="kali@localhost"
MESSAGE="/home/kali/Documents/nmap_diff/alert.txt"
d=$(date +%Y-%m-%d)
y=$(date -d yesterday +%Y-%m-%d)
dir=/home/kali/Documents/nmap_diff

/usr/bin/nmap -oX $dir/scan_$d.xml $ip > /dev/null 2>&1

if [ -e $dir/scan_$y.xml ]; then
        /usr/bin/ndiff $dir/scan_$y.xml $dir/scan_$d.xml > $dir/diff_$ip.txt
        echo "DIFF NMAP CHANGE PLEASE CHECK DIR $dir" >> $MESSAGE
        /usr/bin/mail -s "$SUBJECT" "TO" < $MESSAGE
        rm $MESSAGE
fi


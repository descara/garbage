#!/bin/bash

#  run.sh
# Generate an XML feed from a list of blacklisted IP addresses
# Author: Reuben Joseph<reubenej@gmail.com>
# 
# Requirements
# GNU Netcat
# whois

# Python libraries required
# python-geoip


if [ "$1" != ""]; then
	FILE = $1
else
	echo "Enter filename"
fi

echo "Prepare IP file...."
sed -i '1s/^/begin/' $FILE
echo "end" >> $FILE

echo "Getting ASN info"
netcat whois.cymru.com 43 < $FILE | sort -n > output.txt

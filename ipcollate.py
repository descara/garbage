# ipcollate.py
# Strip IP addresses from several files 
# and dump to a single file
# 
# Author: Reuben Joseph <reubenej@gmail.com>
#

import os
import csv

def list_files(dir):
	""" List the files in a directory"""
	for subdir, dirs, files in os.walk(dir):
		for file in files:
			print os.path.join(subdir,file)
			return file
		
def dedup(iplist):
	""" Remove duplicates from a list of values """
	return list(set(iplist))
	
	
def load_file(file):
	""" Recieve a file object and dump to file """
	iplist = []
	try:
		fd = open(file, "rb")
	except IOError:
		print "Error cannot read the file"
	else:
		reader = csv.reader(fd, delimiter= ' ',)
		for row in reader:
			iplist.append(row)
		
		fd.close()
	return iplist
	


	
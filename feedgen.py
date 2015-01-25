#!/usr/bin/env python

from xml.etree.ElementTree import Element, SubElement
from xml.etree import ElementTree
from xml.dom import minidom
from time import gmtime, strftime
import csv

# Read CSV file into list
def read_file(filename):
	# List of IP addresses
	ips = []
	with open(filename, 'rb') as file:
		reader = csv.reader(file)
		for row in reader:
			ips.append(row)
	
	return ips

"""
	Atom Feed generating functions
"""
def prettify(elem):
	"""Returns a prettified XML string 
	"""
	crap_string = ElementTree.tostring(elem, 'utf-8')
	reparsed = minidom.parseString(crap_string)
	return reparsed.toprettyxml(indent=" ", encoding="utf-8")
	
def add_entry(feed, ip):
	entry = SubElement(feed, 'entry')
	
	#title = SubElement(entry, 'title')
	updated = SubElement(entry, 'updated')
	updated.text = strftime("%Y-%m-%d %H:%M:%S", gmtime())
	summary = SubElement(entry, 'summary')
	summary.text = str(ip)
	return entry

def generate_feed():
	top = Element('feed')
	top.set('xmlns','http://www.w3.org/2005/Atom')
	
	title = SubElement(top, 'title')
	title.text = 'CIF Feed'
	
	id = SubElement(top, 'id')
	id.text = 'https://cif.cifserver.com'
	
	author = SubElement(top, 'author')
	#author.text = 'CIF Server'
	
	name = SubElement(author, 'name')
	name.text = 'CIF Server'
	
	data = read_file('data.csv')
	
	#Populate feed
	for line in data:
		add_entry(top, line)
		
	print prettify(top)
	
generate_feed()	
	
#if __name__ == "__main__":
	# Enter code here
	
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
	item = SubElement(feed, 'item')
	
	#title = SubElement(entry, 'title')
	title = SubElement(item, 'title')
	title.text = strftime("%Y-%m-%d %H:%M:%S", gmtime())
	desc = SubElement(item, 'description')
	desc.text = ip
	return item

def generate_feed():
	top = Element('rss')
	top.set('xmlns:atom','http://www.w3.org/2005/Atom')
	top.set('version', '2.0')
	
	channel = SubElement(top, 'channel')
	
	link = SubElement(channel, 'link')
	link.text = 'https://cif.cifserver.com'
	
	description = SubElement(channel, 'description')
	description.text = 'Sample feed CIF Server'
	
	language = SubElement(channel, 'language')
	language.text = 'en'
	
	data = read_file('data.csv')
	#Populate feed
	for line in data:
		add_entry(channel, str(line))
		
	print prettify(top)
	

if __name__ == "__main__":
	# Enter code here
	generate_feed()		
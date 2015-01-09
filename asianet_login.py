# Asianet Login script
# Logs into your asianet broadband account and
# keeps a connection open

# Requires python2.7 with urllib2
# Author: rjosph <reubenej@gmail.com>


import urllib2
import os

# Gotta think of a more secure way of storing credentials
auth_user = "TV100270"
auth_pass = "ch17op90in"
ping_host = 'https://google.com/'

    
def keep_alive():
    """Send GET requests to keep connection open"""
    request = urllib2.Request(ping_host)

def check_connected():
    """Check if you are already connected to the internet"""

if __name__ == '__main__':
    # Initalize some basic settings
    osname = os.name
    if osname == 'nt':
        homedir = os.getenv('USERPROFILE')  # For Windows
    else:
        homedir = os.getenv('HOME')     # For UNIX systems

    print homedir	
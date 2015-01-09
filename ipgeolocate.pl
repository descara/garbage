#!/usr/bin/env perl -w

# ipgeolocate 
# Get geolocation information for specified
# IP address. Makes use of IPInfoDB database
#
# Author: Reuben Joseph (rjosph) <reubenej@gmail.com>

use strict;
use vars qw($API_KEY);
use HTTP::Tiny;
use JSON;

# die unless parameters specified
die "Usage: ipgeolocate options <IP address> 
         Options:
             city       - Results with city precision
             country    - Results with country precision \n"
    unless @ARGV == 2;

# Your API key here
$API_KEY = " ";

sub generate_uri {
    my ($option, $ip) = @_;

    my $base_country = "http://api.ipinfodb.com/v3/ip-country/?key=";
    my $base_city = "http://api.ipinfodb.com/v3/ip-city/?key=";
    my $uri;

    if ($option eq 'city') {
        $uri = $base_city . $API_KEY . "&ip=$ip&format=json";
        return $uri;
    }

    else {
        $uri = $base_country . $API_KEY . "&ip=$ip&format=json";
        return $uri;
    }
}

# JSONify data and return an Array of JSON values
sub jsonify {
   my ($jsontext) = @_;
   my $decoded_json = decode_json($jsontext);
}

# Display Geolocation Information
sub display {
    my ($data) = @_;
    my $ipinfo = jsonify($data);

    # Dump data in pretty format
    print "IP: " . "$ipinfo->{'ipAddress'}\n";
    print "City: " . "$ipinfo->{'cityName'}\n";
    print "Region: " . "$ipinfo->{'regionName'}\n";
    print "Country: " . "$ipinfo->{'countryName'}\n";
    print "Latitude: " . "$ipinfo->{'latitude'}\n";
    print "Longitude: " . "$ipinfo->{'longitude'}\n";
}

# Generate URI for lookup
my $api_uri = generate_uri(@ARGV);
# Perform Lookup request
my $response = HTTP::Tiny->new->get($api_uri);
die "Request failed!" unless defined($response);

my $data = $response->{content};
#print $data;
display($data);

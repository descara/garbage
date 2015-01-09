#!/usr/bin/perl -w 

#
# Simple script to search for ThreatExpert
# Analysis reports. Search makes use of sample md5 values.
# Output is dumped to STDOUT
#
# Source: http://www.malc0de.com

use LWP::Simple;

$input = $ARGV[0];


$url = 'http://www.threatexpert.com/report.aspx?md5='.$input;
my $fetch = get($url);

if ( md5check () >= 0 and 
	$fetch !~ m/Sign In/g) {
	$fetch =~ s/\<[^>]*\>//g;
	$fetch =~ s/&nbsp;//g;
	$fetch =~ s/"//g;
	$fetch =~ s/body a \{color:(.*)\}//g;
	$fetch =~ s/_uacct =(.*)\;//g;
	print $fetch;
}else{
	print "\n\n\n"."$input has not been submitted"."\n\n\n";
}


sub md5check{
if ($input =~ m/[0-9a-f]{32}/i){
	$input =~ tr/a-z/A-Z/;
}else{
	print "\n\n\n"."Valid MD5 Please"."\n\n\n";
	exit;
	}
}




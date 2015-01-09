#!/usr/bin/perl -w

#
#Simple perl script to parse pastebin to alert on keywords of interest. 
#1)Install the the LWP and MIME perl modules
#2)Create two text files one called keywords.txt and tracker.txt
#2a)keywords.txt is where you need to enter keywords you wish to be alerted on, one per line.
#3)Edit the code below and enter your smtp server, from email address and to email address. 
#4)Cron it up and receive alerts in near real time
#

use Data::Dumper;
use LWP::Simple;
use LWP::UserAgent;
use MIME::Lite;
MIME::Lite->send('smtp','#enter smtp server', Timeout=>60);

my $ua = new LWP::UserAgent;
$ua->agent("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1");

my $req = new HTTP::Request GET => 'http://pastebin.com/archive';
my $res = $ua->request($req);
my $pastebin = $res->content; 

#date
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
my $datestring = sprintf("%4d-%02d-%02d",($year + 1900),($mon+1),$mday-1);
my $dir = sprintf("%4d-%02d",($year + 1900),($mon+1));


open (MYFILE, 'keywords.txt');
my @keywords = <MYFILE>;
chomp(@keywords) ;
my $regex = join('|', @keywords);
my $tracking_file = 'tracker.txt';
my @links = getlinks();

if (@links) {
	foreach $line (@links){
		if  (checkurl($line) == 0){
		my $request = "http://pastebin.com/$line\n";
		my $link = $line;
		my $req = new HTTP::Request GET => "$request";	
		my $res = $ua->request($req);
		my $content = $res->content;
		my @data = $content;
		foreach $line (@data){
			if ($content =~ m/\<textarea.*?\)\"\>(.*?)\<\/textarea\>/sgm){	
			@data = $1; 
			print $content;
			foreach $line (@data){
				if ($line =~ m/($regex)$/i){
				storeurl($link);
				print "$request $line\n";
				my $msg = MIME::Lite->new(
    					From    => '#enter from address',
    					To      => '#enter your email address;',
    					Cc      => '',
    					Subject => "Keyword Detected ($1) $request",
    					Type    => 'multipart/mixed',
    					Data     =>"",
					);
				$msg->attach(
  					Type     => 'TEXT',
    					Data     => "\n\n$line\n\n",
					);
					$msg->send;
						}
					}
				}
			}
		}		
	}
}


sub getlinks{
    my @results;
    if (defined $pastebin) {
        @data = $pastebin;
        foreach $line (@data){
            while ($line =~ m/border\=\"0\"\s\/\>\<a\shref\=\"\/(.*?)"\>/g){
                my $url = $1;
        	push (@results, $url);        
			}
		}
	}
   
  return @results;
}

sub storeurl {
        my $url = shift;
        open (FILE,">> $tracking_file") or die("cannot open $tracking_file");
        print FILE $url."\n";
        close FILE;
}

sub checkurl {
        my $url = shift;
        open (FILE,"< $tracking_file") or die("cannot open $tracking_file");
        foreach my $line ( <FILE> ) {
                if ( $line =~ m/$url/i ) {
                        return 1;
                }
        }
        return 0;
}


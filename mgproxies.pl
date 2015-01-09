#!/usr/bin/perl -w

#Simple script to interface with malwaregroup.com, pulls down a list of active proxies and writes to your .wgetrc file. 
#best if used with cron

# Sample .wgetrc file
#http_proxy =
#user_agent = Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6
#referer = http://www.google.com
#
# Source: http://www.malc0de.com


use LWP::Simple;
use LWP::UserAgent;
use HTTP::Request::Common;


my $ua = new LWP::UserAgent;
$ua->agent("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1");


my $req = new HTTP::Request GET => 'http://www.malwaregroup.com/Proxies';
my $res = $ua->request($req);
my $content = $res->content;


#set to path to your home dir
my $file = '.wgetrc';

if ( $content =~ m/\">([\d\.]{7,}.*?)\<\/a\>\<\/td\>\s\<td\>(.*?)\<\/td\>/ig ){
                my $proxy = "$1:$2";

        open (FILE, "< $file");
        my @wgetrc = <FILE>;
        close (FILE);

        open (FILE,"> $file");
        foreach $line (@wgetrc){
                if ($line =~ m/^http_proxy.*?/gi ) {
                        print FILE "http_proxy = http://$proxy";
                } else {
                        print FILE $line;
                }
        }
        close(FILE);

}


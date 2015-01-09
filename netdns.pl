#!/usr/bin/perl

# 
#
#
#
#

use Socket;

open(FILE, $ARGV[0]);
@domains = <FILE>;
close(FILE);

foreach $domain (@domains) {
   chomp($domain);
   if($domain) {
      print $domain.' '; 
      $ipaddr = gethostbyname($domain);
      if($ipaddr) {
        printf "%s\n" , inet_ntoa($ipaddr);
      } else {
        print "Cannot be resolved\n";
      }
   }
}

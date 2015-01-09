#!/usr/bin/env perl

# hasher 
# Compute file hashes for files
# Supports MD5 and SHA
# Authur: Reuben Joseph (rjosph) <reubenej@gmail.com>

use strict;
use warnings;
use Digest::MD5;
use Digest::SHA;

my ($filename) = @ARGV;

open(my $fh, "<", $filename) or die "Cannot open file $!";
binmode($fh);

my $md5 = Digest::MD5->new;
my $sha = Digest::SHA->new;
my $sha256 = Digest::SHA->new(256);
print "MD5\n";
print $md5->addfile($fh)->hexdigest, " $filename\n";
print "SHA\n";
print $sha->addfile($fh)->hexdigest, " $filename\n";
print "SHA256\n";
print $sha256->addfile($fh)->hexdigest, " $filename\n";


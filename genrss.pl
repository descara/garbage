use strict;
use warnings;
use XML::RSS;
use Text::CSV;

sub read_file {
	my ($filename) = @_;
	
	my @rows;
	my $csv = Text::CSV_XS->new({binary => 1, sep_char => ','});
	open(my $fh, '<', $filename)
		or die "Could not open $filename: $!";
		
	while(my $row = $csv->getline($fh)) {
		push @rows, $row;
	}
	close $fh;
	
	return @rows;
}

# Generate an RSS feed from data
generate_feed {
	my $feed = XML::RSS->new(version => '1.0');
	
	# REM: Array of references
	my @data = read_file('data.csv');
	# Define channel
	$feed->channel(
		title				=>		"CIF Feed",
		link				=>		"Something",
		description			=>		"Sample CIF feed for testing",		
	);
	
	# Populate feed
#	while(my $item = shift(@data)) {
#		$feed->add_item(
#			title	=>	"$item",
#			link	=>	"$item"
#		);	
#	}
	
	print $feed->as_string;
}

#my @data = read_file('data.csv');

generate_feed;
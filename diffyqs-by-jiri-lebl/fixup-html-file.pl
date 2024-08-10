#!/usr/bin/perl

# This is hackish, but I can't figure out how to modify the html output otherwise

my ($arg) = @ARGV;

while($line = <STDIN>)
{
	if ($line =~ m/<a class="index-button.*title="Index"/) {
		# Add extra buttons

		$extra = "<a class=\"index-button button\" href=\"https://www.jirka.org/diffyqs/\" title=\"Home\" alt=\"Book Home\"><span class=\"name\">Home</span></a>\n";

		$extra .= "<a class=\"index-button button\" href=\"https://www.jirka.org/diffyqs/diffyqs.pdf\" title=\"PDF\"><span class=\"name\">PDF</span></a>\n";

		$extra .= "<a class=\"index-button button\" href=\"https://www.amazon.com/dp/1706230230\" title=\"Paperback\" alt=\"Buy Paperback\"><span class=\"name\">Paperback</span></a>\n";

		if (not ($line =~ s/<div class="searchbox"/$extra<div class="searchbox"/)) {
			print STDERR "Can't add extra buttons!";
			exit 1;
		}
	}
	if ($line =~ m/<\/head>/) {
		print "<style>\n";
		# Not really critical, avoids flashing some LaTeX code on initial load, as external .css files get loaded slowly
		print " .hidden-content { display:none; }\n";
		# This is for the print PDF warning below
		print " .print-pdf-warning { display:none; }\n";
		print " \@media print { .print-pdf-warning { display:inline; } }\n";
		print "</style>\n";
	}
	if ($line =~ m/<\/body>/) {
		print "<span class=\"print-pdf-warning\">\n";
		print " <em>For a higher quality printout use the PDF version: <tt>https://www.jirka.org/diffyqs/diffyqs.pdf</tt></em>\n";
		print "</span>\n";
	}
	# no longer there
	#$line =~ s/>Authored in PreTeXt</>Created with PreTeXt</;
	
	# In case chtml is broken again
	#$line =~ s/^  chtml: {/  svg: {/;
	#$line =~ s/tex-chtml[.]js/tex-svg.js/;

	#print line
	print $line;
}

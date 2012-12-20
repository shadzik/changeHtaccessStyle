#!/usr/bin/perl
#####################################################
# Aendert den Allow/Deny From Stil von Apache 2.2
# zu dem Require... Stil von Apache 2.4
#####################################################
# (c) 2012 Bartosz Swiatek (b@atwa.us)
#####################################################
use strict;
use warnings;
use POSIX qw/strftime/;

if (!@ARGV) {
	print "Usage: $0 <htaccess_file>\n";
	exit(1);
}

my $date = strftime "%d.%m.%Y", localtime;

my $DEBUG = 0;
my $file = $ARGV[0];
open my $htaccess, $file or die "Could not open $file: $!";
my $output;

while (my $line = <$htaccess>)  {
	my $newline = '';
	chomp $line;
	$line =~ s/^\s+//;
	if ($line =~ /^order/i) {
		$line = '# ' . $line;
		$line = "# Auskommentiert durch $0 Skript am $date\n$line";
	}
	if ($line =~ /^deny/i) {
		$newline = $line;
		$line = '# ' . $line;
		$newline =~ s/^deny from //i;
		#$newline = "Require all denied\n" if ($newline =~ /all/i)
		if ($newline =~ /all/i) { 
			$newline = "Require all denied\n";
		} else {
			$newline = '';
		}
	}
	if ($line =~ /^allow/i) {
		$newline = $line;
		$newline =~ s/^allow from //i;
		my @nl_array = split( /[\t ]+/, $newline );
		$newline = '';
		foreach (@nl_array) {
			if (m/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}|^\d{1,3}\.\d{1,3}\.\d{1,3}\.|^\d{1,3}\.\d{1,3}\.|^\d{1,3}\./) {
				$newline .= "Require ip $_";
			} elsif (/all/i) {
				$newline .= "Require $_ granted";
			} else {
				$newline .= "Require host $_";
			}
			$newline.="\n";
		}
		$line = '# ' . $line;
	}
	$output .= "$line\n$newline";
}
close $htaccess;

if ($DEBUG) {
	print $output;
} else {
	open FILE, ">$file" or die "Could not open $file: $!";
	print FILE $output;
	close FILE
}

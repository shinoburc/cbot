#!/usr/bin/perl

# $Id: cookpad.pl 115 2009-08-13 14:58:08Z dot $

use strict;
use warnings;
use XML::RSS;
use LWP::Simple;

my $uri = "http://cookpad.com/search/post?keyword=$ARGV[0]";

my $rss = new XML::RSS;
my $content = get($uri);
die "Could not retrieve $uri" unless $content;

my $count = 0;
foreach my $line (split /\n/,$content){
    $count++ if $line =~ /<!---->/;
    exit if $count > 8;
    if($count == 3 || $count == 7 || $count == 8){
        $line =~ s/<.*?>//g;
        $line =~ s/[ ]*//;
        if($line ne ""){
            print $line . "\n";
            $count++;
        }
    }
}

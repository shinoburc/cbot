#!/usr/bin/perl

# $Id: it-keyword.pl 117 2009-08-13 16:02:08Z dot $

use strict;
use warnings;
use LWP::Simple;

my $uri = "http://www.sophia-it.com";

my $content = get($uri);
die "Could not retrieve $uri" unless $content;

my @lines = split /\r/,$content;
while(my $line = shift @lines){
    if($line =~ /<td class=rankin(.*)>/){
        shift @lines;
        $line = shift @lines;
        $line =~ s/\n//;
        $line =~ s/<.*?>//g;
        $line =~ s/\(.*?\)//g;
        $line =~ s/&nbsp;//g;
        $line =~ s/（用語辞典）//g;
        $line =~ s/[ ]*//;
        if($line ne ""){
            print $line . "\n";
        }
    }
}

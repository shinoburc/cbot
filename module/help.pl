#!/usr/bin/perl

# $Id: help.pl 120 2009-08-13 16:53:11Z dot $

use strict;
use warnings;
use Config::YAML;

my $conf = Config::YAML->new(config => "cbot.yaml");
my $list = $conf->{'regexlist'};

foreach my $regex(sort {$list->{$a} cmp $list->{$b}} keys %$list){
    my $display_regex = $regex;
    # TODO DRY
    $display_regex =~ s/(\.\*)/KEYWORD/g;
    $display_regex =~ s/[ \[\]\$\\\^\\\.\*(\)]//g;
    printf "%-10s\t : %s\n",$display_regex,$list->{$regex};
}

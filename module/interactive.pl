#!/usr/bin/perl

# $Id: interactive.pl 115 2009-08-13 14:58:08Z dot $

use strict;
use warnings;
use Config::YAML;

my $conf = Config::YAML->new(config => "cbot.yaml");
my $list = $conf->{'interactive_' . $ARGV[0]};
$list = $conf->{'interactive'} if !defined($list);
die "Who am I?\n" if !defined($list);

my @keys = keys %$list;
print $keys[int(rand(@keys))] . "\n" if defined($keys[int(rand(@keys))]);

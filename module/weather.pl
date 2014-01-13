#!/usr/bin/perl

use strict;
use XML::RSS;
use LWP::Simple;

my $uri = "http://weather.livedoor.com/forecast/rss/47/136.xml";

my $rss = new XML::RSS;
my $content = get($uri);
die "Could not retrieve $uri" unless $content;
$rss->parse($content);

binmode(STDOUT, ":utf8");
foreach my $item (@{$rss->{'items'}}) {
    next unless defined($item->{'description'});
    next if defined($item->{'title'}) && $item->{'title'} =~ /\[ PR \]/;
    print $item->{'description'} . "\n";
}


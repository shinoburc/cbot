#!/usr/bin/perl

use strict;
use XML::RSS;
use LWP::Simple;
use NKF;

# TODO
my $uri = "http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=le";
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=cp
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=aq
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=pi
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=ar
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=ta
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=ge
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=ca
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=le
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=vi
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=li
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=sc
#http://woman.excite.co.jp/fortune/xml/?f=horoscope&sign=sa

my $rss = new XML::RSS;
my $content = nkf("-w",get($uri));
$content =~ s/Shift_JIS/UTF-8/g;
die "Could not retrieve $uri" unless $content;
$rss->parse($content);

binmode(STDOUT, ":utf8");
foreach my $item (@{$rss->{'items'}}) {
    next unless defined($item->{'title'});
    print $item->{'title'} . "\n";
}


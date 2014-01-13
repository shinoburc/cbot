#!/usr/bin/perl

# $Id: movie.pl 113 2009-08-13 14:18:47Z dot $

use strict;
use warnings;
use LWP::Simple;
use NKF;

my $encoding = '-w';

my %urls = ( 
          'Southern_Plex'  => 'http://movie.okinawajoho.net/cinema_hall.php?id=5'
         ,'CINEMAS_Q'      => 'http://movie.okinawajoho.net/cinema_hall.php?id=1'
         ,'MIHAMA_7Plex'   => 'http://movie.okinawajoho.net/cinema_hall.php?id=4'
         ,'CINEMA_PALETTO' => 'http://movie.okinawajoho.net/cinema_hall.php?id=2'
         ,'SAKURAZAKA'     => 'http://movie.okinawajoho.net/cinema_hall.php?id=3'
);

print &parse($urls{$ARGV[0]});

sub parse {
    my $uri = shift;
    my $rtn;

    my $content = get($uri);
    die "Could not retrieve $uri" unless $content;
    foreach my $line (split /\n/,$content){
    	$line = nkf($encoding,$line);
        if($line =~ /<font color="#FFFFFF"><img src="_img\/kado01.gif" width="20" height="20">タイトル：<b>(.*)<\/b>/){
            $rtn .= "$1\n";
        }
    
        if($line =~ /<td width="10%" class="middle"><font color="#FFFFFF">(.*)<\/font><\/td>/){
            #$rtn .= "    " . $1 . "\n";
        }
        if($line =~ /<td width="80%" class="middle"><font color="#FFFFFF"><b>(.*)<\/b><\/font><\/td>/){
            $rtn .= "    " . $1 . "\n";
        }
     
        if($line =~ /<td class="middle"><div align="right"><font color="#FFFFFF">(.*)<\/font><\/div><\/td>/){
            $rtn .= "    " . $1;
        }
        if($line =~ /<td class="middle"><font color="#FFFFFF"><b>(.*)<\/b><\/font><\/td>/){
            $rtn .= "" . $1 . "\n";
        }
    }
    return $rtn;
}

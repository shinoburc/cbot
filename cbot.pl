#!/usr/bin/perl
# $Id: cbot.pl 121 2009-08-13 17:05:42Z dot $

use strict;
use warnings;

use Config::YAML;
use Term::ReadLine;
use List::Util;

my $module_dir = "./module";
my @exit_command = qw(exit quit bye ばいばい);

my $conf = Config::YAML->new(config => "cbot.yaml");

my $list = $conf->{'regexlist'};
my $term = new Term::ReadLine 'cbot';

my $attribs = $term->Attribs;
$attribs->{completion_entry_function} = $attribs->{list_completion_function};
$attribs->{completion_word} = [&gen_completion_entry];

while ( defined (my $input = $term->readline("cbot >")) ) {
    foreach my $regex(keys %$list){
        if($input =~ /$regex/){
            if(defined($1)){
                &exec_module($list->{$regex},$1);
            } else {
                &exec_module($list->{$regex},"");
            }
        }
    }
    exit if ( List::Util::first{$input =~ /^[ ]*$_[ ]*$/} @exit_command);
}

sub exec_module($$){
    my $module = shift;
    my $arg = shift;
    system "perl " . $module_dir . "/$module.pl '$arg'";
}

sub gen_completion_entry{
    foreach my $regex (keys %$list){
        $regex =~ s/[ \[\]\$\\\^\.\*\(\)]//g;
        push @_,$regex;
    }
    return (@_, @exit_command);
}

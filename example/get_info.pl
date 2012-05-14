#!/usr/bin/perl
package main;

use strict;
use warnings;
use WebService::TenkiJp::Typhoon;

our $DEBUG = shift @ARGV;

my $wt = WebService::TenkiJp::Typhoon->new();
$wt->get_info;

if($wt->exist){
  my $description =  $wt->info->{description};
  my $next_word_regex = q{次回の.*$};
  $description =~ s{(.*)?$next_word_regex}{$1};
  warn $description;
}
else {
  warn 'not exist';
}

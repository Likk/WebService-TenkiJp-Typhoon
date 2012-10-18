#!/usr/bin/perl
package main;

use strict;
use warnings;
use WebService::TenkiJp::Typhoon;

our $DEBUG = shift @ARGV;

my $wt = WebService::TenkiJp::Typhoon->new();
$wt->get_info;

if($wt->exist and scalar @{$wt->info}){
  my $description_list =  $wt->info;
  for my $row (@{$wt->info}){
    my $next_word_regex = q{次回の.*$};
    $row =~ s{(.*)?$next_word_regex}{$1};
    warn $row;
  }
}
else {
  warn 'not exist';
}

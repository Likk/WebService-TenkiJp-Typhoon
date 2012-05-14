use strict;
use Test::More tests => 1;
use WebService::TenkiJp::Typhoon;

my $wt = WebService::TenkiJp::Typhoon->new();

isa_ok($wt,'WebService::TenkiJp::Typhoon', 'isa test');

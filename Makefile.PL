use inc::Module::Install;
name 'WebService-TenkiJp-Typhoon';
all_from 'lib/WebService/TenkiJp/Typhoon.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;

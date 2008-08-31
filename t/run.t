#!/usr/bin/perl

use Test::More 'no_plan';

my $class = 'Net::MAC::Vendor';

use_ok( $class );
ok( defined &{"${class}::run"}, "run() method is defined" );
can_ok( $class, qw(run) );

{
local *STDOUT;

open STDOUT, ">", \ my $output;

my $rc = $class->run( '00:0d:93:84:49:ee' );

like( $output, qr/Apple/, 'OUI belongs to Apple');
}
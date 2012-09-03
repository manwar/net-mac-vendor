use Test::More;

my $class = 'Net::MAC::Vendor';

use_ok( $class );
ok( defined &{"${class}::load_cache"}, "&load_cache is defined" );

{
local *STDERR;
open STDERR, ">", \my $output;
my $rc = Net::MAC::Vendor::load_cache( 'not_there.txt' );
is( $rc, undef, "load_cache returns undef for bad source [not_there.txt]");
}

{
local *STDERR;
open STDERR, ">", \my $output;
my $rc = Net::MAC::Vendor::load_cache();
ok( $rc, "load_cache returns true for default source");
}

done_testing();

use Test::More;
use File::Temp qw/ tempfile /;

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

my ($fh, $filename) = tempfile( undef, UNLINK => 1 );
{
local *STDERR;
open STDERR, ">", \my $output;
my $rc = Net::MAC::Vendor::load_cache(undef,$filename);
ok( $rc, "load_cache returns true for default source with write");
}

ok ( -s $filename, "load_cache results in file with size > 0");

{
local *STDERR;
open STDERR, ">", \my $output;
my $rc = Net::MAC::Vendor::load_cache($filename);
ok( $rc, "load_cache returns true read from created source");
}

done_testing();

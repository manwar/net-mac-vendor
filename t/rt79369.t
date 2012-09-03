use Test::More 0.98;
use strict;
use warnings;

use File::Spec::Functions;

my $class = 'Net::MAC::Vendor';

use_ok( $class );

my $private_mac = '00-00-6C';

subtest html => sub {
	my $array = Net::MAC::Vendor::lookup( $private_mac );
	isa_ok( $array, ref [], "Got back array reference" );

	is( $array->[0], 'PRIVATE', 'This is a private entry' );
	};

subtest local_cache => sub {
	my $file       = catfile( qw(extras oui-small.txt) );
	my $cache_file = Net::MAC::Vendor::cache_file_name();

	ok( Net::MAC::Vendor::load_cache( $file ), 'Cache is loaded' );
	ok( -e $cache_file, "Cache file $cache_file exists" );
	
	my $array = Net::MAC::Vendor::lookup( $private_mac );
	isa_ok( $array, ref [], "Got back array reference" );
	is( $array->[0], 'PRIVATE', 'This is a private entry' );

	unlink( $cache_file );
	ok( ! -e $cache_file, "Cache file $cache_file has been unlinked" );
	};

done_testing();

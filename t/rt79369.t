use Test::More 0.98;
use strict;
use warnings;

=pod

I think the data file format that caused this problem no longer
exists in their data, so this is historical

=cut

pass();
done_testing();
exit;

use File::Spec::Functions;

my $class = 'Net::MAC::Vendor';

use_ok( $class );

my $private_mac = '00-00-6C';

subtest html => sub {
	SKIP: {
		my $array = Net::MAC::Vendor::lookup( $private_mac );
		skip 'Could not fetch MAC data', 2 unless defined $array;

		isa_ok( $array, ref [], "Got back array reference" );

		is( uc $array->[0], 'PRIVATE', 'This is a private entry' );
		}
	};

subtest local_cache => sub {
	my $file       = catfile( qw(extras oui-small.txt) );

	ok( Net::MAC::Vendor::load_cache( $file ), 'Cache is loaded' );

	my $array = Net::MAC::Vendor::lookup( $private_mac );
	isa_ok( $array, ref [], "Got back array reference" );
	is( uc $array->[0], 'PRIVATE', 'This is a private entry' );
	};

done_testing();

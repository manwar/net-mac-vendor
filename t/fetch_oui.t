# $Id$

use Test::More tests => 12;

use LWP::Simple qw(head);

use_ok( 'Net::MAC::Vendor' );

my @oui = qw( 00-0D-93 );


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
my $connected = head( 'http://standards.ieee.org/regauth/oui/oui.txt' );

ok( defined $connected, "Am connected to network" );

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
SKIP: {
skip "Can't connect to the IEEE web site", 4 unless $connected;

Net::MAC::Vendor::fetch_oui( $oui[0] );

my $lines =
	[
	'Apple Computer',
	'1 Infinite Loop',
	'Cupertino CA 95014',
	'UNITED STATES',
	];
	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
foreach my $oui ( @oui )
	{
	my $parsed = Net::MAC::Vendor::fetch_oui( $oui );

	foreach my $i ( 0 .. $#$parsed )
		{
		is( $parsed->[$i], $lines->[$i], "Line $i matches for $oui" );
		}
	}

}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
SKIP: {
require Cwd;
require File::Spec;

my $cwd  = Cwd::cwd();
my $path = File::Spec->catfile( $cwd, "extras/oui-20060623.txt" );

skip "Can't get path to data file [$path]", 4 unless -e $path;

my $uri  = "file://" . $path;

Net::MAC::Vendor::load_cache( $uri );

SKIP: {
	skip "No DBM::Deep", 1 unless eval "require DBM::Deep";
	ok( -e 'mac_oui.db', "Cache file exists" );
	}
	
my $lines =
	[
	'Apple Computer',
	'1 Infinite Loop',
	'Cupertino CA 95014',
	'UNITED STATES',
	];

foreach my $oui ( @oui )
	{
	my $parsed = Net::MAC::Vendor::fetch_oui_from_cache( $oui );

	foreach my $i ( 0 .. $#$parsed )
		{
		is( $parsed->[$i], $lines->[$i], "Line $i matches for $oui" );
		}
	}

unlink( 'mac_oui.db' );
ok( ! -e 'mac_oui.db', "Cache file has been unlinked" );
}
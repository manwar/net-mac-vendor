# $Id$

use Test::More tests => 11;

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
{
Net::MAC::Vendor::load_cache();

my $lines =
	[
	'Apple Computer',
	'1 Infinite Loop',
	'Cupertino CA 95014',
	'UNITED STATES',
	];

foreach my $oui ( @oui )
	{
	my $parsed = Net::MAC::Vendor::fetch_ouifrom_cache( $oui );

	foreach my $i ( 0 .. $#$parsed )
		{
		is( $parsed->[$i], $lines->[$i], "Line $i matches for $oui" );
		}
	}

}
use Test::More 0.98;

use LWP::Simple qw(head);

use_ok( 'Net::MAC::Vendor' );

my @oui = qw( 00-0D-93 );

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
unlink( 'mac_oui.db' );
ok( ! -e 'mac_oui.db', "Cache file has been unlinked" );

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
my $path = File::Spec->catfile( $cwd, "extras/oui-20080629.txt" );

skip "Can't get path to data file [$path]", 4 unless -e $path;

my $uri  = "file://" . $path;


print STDERR "...Loading cache...\n";
print STDERR "...This could take awhile...\n";
my $start = time;
Net::MAC::Vendor::load_cache( $uri );
my $end = time;
print STDERR "...Cache loaded...\n";

TODO: {
	local $TODO = "Improve performance!";
	cmp_ok( $end - $start, "<", 60 );
	}
	
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

	foreach my $i ( 1 .. $#$parsed )
		{
		is( $parsed->[$i], $lines->[$i], "Line $i matches for $oui" );
		}
	}

unlink( 'mac_oui.db' );
ok( ! -e 'mac_oui.db', "Cache file has been unlinked" );
}

done_testing();

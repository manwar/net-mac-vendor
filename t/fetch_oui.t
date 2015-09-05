use strict;
use warnings;

use Test::More 0.98;

my $class = 'Net::MAC::Vendor';

subtest status => sub {
	use_ok( $class );
	can_ok( $class, 'fetch_oui' );
	};

subtest cache_unlinked => sub {
	unlink( 'mac_oui.db' );
	ok( ! -e 'mac_oui.db', "Cache file has been unlinked" );
	};

my $connected = 0;
subtest connected => sub {
	my $tx = $class->ua->head( Net::MAC::Vendor::oui_url() );
	$connected = $tx->success;
	ok( $connected, "Am connected to network [$connected]" );
	};

my @ouis = qw(
	00-0D-93
	);

my $lines =
	[
	'Apple, Inc.',
	'1 Infinite Loop',
	'Cupertino CA 95014',
	'UNITED STATES',
	];

subtest fetch_apple => sub {
	SKIP: {
		skip "Can't connect to the IEEE web site", 4 unless $connected;

		my $parsed = Net::MAC::Vendor::fetch_oui( $ouis[0] );
		isa_ok( $parsed, ref [] );
		foreach my $i ( 0 .. $#$parsed ) {
			is( $parsed->[$i], $lines->[$i], "Line $i matches for $ouis[0]" );
			}
		}
	};

subtest fetch_all => sub {
	foreach my $oui ( @ouis ) {
		my $parsed = Net::MAC::Vendor::fetch_oui( $oui );
		isa_ok( $parsed, ref [] );
		foreach my $i ( 0 .. $#$parsed ) {
			is( $parsed->[$i], $lines->[$i], "Line $i matches for $oui" );
			}
		}
	};


subtest load_from_cache => sub {
	require Cwd;
	require File::Spec;
	my $path = File::Spec->catfile( Cwd::cwd(), "extras/oui-20150808.txt" );
	diag( "File path is $path" );
	ok( -e $path, "Cached file exists" );

	SKIP: {
		skip "Can't get path to data file [$path]", 4 unless -e $path;

		diag( "...Loading cache..." );
		Net::MAC::Vendor::load_cache( $path );
		diag( "...Cache loaded..." );

		foreach my $oui ( @ouis ) {
			my $parsed = Net::MAC::Vendor::fetch_oui_from_cache( $oui );

			foreach my $i ( 1 .. $#$parsed ) {
				is( $parsed->[$i], $lines->[$i], "Line $i matches for $oui" );
				}
			}

		}

	};



done_testing();

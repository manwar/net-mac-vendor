# $Id$

use Test::More tests => 7;

use_ok( 'Net::MAC::Vendor' );

my @Good = (
	[ qw( 00:0d:93:84:49:ee 00-0D-93 ) ],
	[ qw( 00:0d:93:29:f6:c2 00-0D-93 ) ],
	[ qw( 00-0d-93-84-49-ee 00-0D-93 ) ],
	[ qw( 00-0d-93          00-0D-93 ) ],
	[ qw( :d:93             00-0D-93 ) ],
	[ qw( 00:d:9            00-0D-09 ) ],
);

foreach my $elem ( @Good )
	{
	my $normalized = Net::MAC::Vendor::normalize_mac( $elem->[0] );
	is( $normalized, $elem->[1], "MAC $$elem[0] is $$elem[1]" ); 
	}	
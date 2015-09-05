use Test::More 0.98;

use Data::Dumper;
my $class = 'Net::MAC::Vendor';

subtest setup => sub {
	use_ok( $class );
	ok( defined &{"${class}::fetch_oui_from_ieee"}, "&fetch_oui_from_ieee is defined" );
	};

subtest fetch => sub {
	my $array = Net::MAC::Vendor::fetch_oui_from_ieee( '00:01:02' );
	isa_ok( $array, ref [], "Got back array reference" );
#	diag( "Array from fetch_oui_from_ieee is " . Dumper( $array ) );

	my $html = join "\n", @$array;

	like( $html, qr/3COM CORPORATION/, "Fetched 3M's OUI entry" );

	unlike( $html, qr/PRIVATE/, "Still see PRIVATE in 3M entry" );
	};

done_testing();

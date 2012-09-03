use Test::More 0.98;

my $module =  'Net::MAC::Vendor';

print "bail out! Could not compile $module.\n"
	unless use_ok( $module );

done_testing();

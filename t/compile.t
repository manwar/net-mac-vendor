use Test::More tests => 1;

my $module =  'Net::MAC::Vendor';

print "bail out! Could not compile $module.\n"
	unless use_ok( $module );
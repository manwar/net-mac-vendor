# $Id$
use ExtUtils::MakeMaker;

eval "use Test::Manifest";
unless( $@ )
   {
   * ExtUtils::MM_Any::test_via_harness = sub
	   {
	   my($self, $perl, $tests) = @_;

	   return qq|\t$perl "-MTest::Manifest" | .
				  qq|"-e" "run_t_manifest(\$(TEST_VERBOSE), '\$(INST_LIB)', | .
				  qq|'\$(INST_ARCHLIB)')"\n|;
	   }
   }

WriteMakefile(
	'NAME'	       => 'Net::MAC::Vendor',
	'VERSION_FROM' => 'lib/Vendor.pm',

	'PREREQ_PM'    => { 
		'Test::More'        => '0',
		},

	'PM'           => {
		'lib/Vendor.pm'         => '$(INST_LIBDIR)/Vendor.pm',
		},

	'MAN3PODS'     => {
		'lib/Vendor.pm' => '$(INST_MAN3DIR)/Net::MAC::Vendor.3',
		},

	clean  => { FILES    => q|Net-MAC-Vendor-* Makefile.old MANIFEST.bak| },

	);

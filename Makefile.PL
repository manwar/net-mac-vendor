# $Id$
use ExtUtils::MakeMaker;

require 5.006;

eval "use Test::Manifest 1.21";

WriteMakefile(
	'NAME'	       => 'Net::MAC::Vendor',
	'ABSTRACT'     => 'look up the network interface vendor by MAC',
	'VERSION_FROM' => 'lib/Vendor.pm',
	'LICENSE'      => 'perl',
	'AUTHOR'       => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM'    => { 
		'Test::More'        => '0',
		'LWP::Simple'       => '0',
		},

	'PM'           => {
		'lib/Vendor.pm'         => '$(INST_LIBDIR)/Vendor.pm',
		},

	clean  => { FILES    => q|Net-MAC-Vendor-* Makefile.old MANIFEST.bak| },

	);

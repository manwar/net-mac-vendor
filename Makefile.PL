use ExtUtils::MakeMaker 6.46;

require 5.006;

eval "use Test::Manifest 1.21";

WriteMakefile(
	'NAME'	       => 'Net::MAC::Vendor',
	'ABSTRACT'     => 'Look up the network interface vendor by its MAC',
	'VERSION_FROM' => 'lib/Net/MAC/Vendor.pm',
	'LICENSE'      => 'perl',
	'AUTHOR'       => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM'    => { 
		'Test::More'        	=> '0.98',
		'LWP::Simple'       	=> '0',
		'LWP::protocol::https'	=> '0',
		},

	'META_MERGE' => {
        'meta-spec' => { version => 2 },
		resources => {
			repository => {
				type => 'git',
				url  => 'git@github.com:briandfoy/net-mac-vendor.git',
				web  => 'https://github.com/briandfoy/net-mac-vendor',
				},
			},
		},

	clean  => { FILES    => q|Net-MAC-Vendor-* Makefile.old MANIFEST.bak| },

	);

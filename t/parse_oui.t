# $Id$

use Test::More tests => 5;

use_ok( 'Net::MAC::Vendor' );

my @oui = (  

# # # # # # # # # # # # # # # # # # #
["00-0D-07   (hex)             Calrec Audio Ltd
000D07     (base 16)            Calrec Audio Ltd
                                Nutclough Mill
                                Hebden Bridge West Yorkshire HX7 8EZ
                                UNITED KINGDOM",
                                
               [
	'Calrec Audio Ltd',
	'Nutclough Mill',
	'Hebden Bridge West Yorkshire HX7 8EZ',
	'UNITED KINGDOM',
	]
],                 
# # # # # # # # # # # # # # # # # # #
          );
          
foreach my $elem ( @oui )
	{
	my $parsed = Net::MAC::Vendor::parse_oui( $elem->[0] );

	foreach my $i ( 0 .. $#$parsed )
		{
		is( $parsed->[$i], $elem->[1][$i], "Line $i matches" );
		}
	}

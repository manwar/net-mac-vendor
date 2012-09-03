use Test::More tests => 4;

use_ok( 'Net::MAC::Vendor' );

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Something that works
{
my $html = <<"HTML";
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<HTML><HEAD><TITLE>Search Results: IEEE Standards OUI Public Database</TITLE>
<LINK REV=MADE HREF="mailto:w.pienciak%40ieee.org">
</HEAD><BODY BGCOLOR="#fffff0"> <p>Here are the results of your search through the public section
        of the IEEE Standards OUI database report for <b>00-0D-07</b>:

<hr><p><pre><b>00-0D-07</b>   (hex)             Calrec Audio Ltd
000D07     (base 16)            Calrec Audio Ltd
                                Nutclough Mill
                                Hebden Bridge West Yorkshire HX7 8EZ
                                UNITED KINGDOM
</pre></p>
        <hr><p>Your attention is called to the fact that the firms and numbers
        listed may not always be obvious in product implementation.  Some
        manufacturers subcontract component manufacture and others include
        registered firms' OUIs in their products.</p>
        <hr>
        <h5 align=center>
        <a href="/index.html">[IEEE Standards Home Page]</a> -- 
        <a href="/search.html">[Search]</a> --
        <a href="/cgi-bin/staffmail">[E-mail to Staff]</a> <br>
        <a href="/c.html">Copyright &copy; 2004 IEEE</a></h5>
HTML

my $expected_oui = <<"OUI";
00-0D-07   (hex)             Calrec Audio Ltd
000D07     (base 16)            Calrec Audio Ltd
                                Nutclough Mill
                                Hebden Bridge West Yorkshire HX7 8EZ
                                UNITED KINGDOM
OUI

{
my $oui = Net::MAC::Vendor::extract_oui_from_html( $html, '00-0D-07' );
is( $oui, $expected_oui, "Extracted OUI" );
}


}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Entries after PRIVATE entries have extra data
{
my $html = <<"HTML";
<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
<head>
<title>Search Results: IEEE Standards OUI Public Database</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body bgcolor="#fffff0">
	<p>Here are the results of your search through the public section
	of the IEEE Standards OUI database report for <b>000102</b>:

<hr><p><pre>00-01-01   (hex)		PRIVATE
000101     (base 16)		 
				 
00-01-02   (hex)		3COM CORPORATION
<b>000102</b>     (base 16)		3COM CORPORATION
				5400 Bayfront Plaza  - MS: 4220
				Santa Clara CA 95052
				UNITED STATES
</pre></p>
	<hr><p>Your attention is called to the fact that the firms and numbers
	listed may not always be obvious in product implementation.  Some
	manufacturers subcontract component manufacture and others include
	registered firms' OUIs in their products.</p>
	<hr>
	<h5 align=center>
	<a href="/index.html">[IEEE Standards Home Page]</a> -- 
	<a href="/search.html">[Search]</a> --
	<a href="/cgi-bin/staffmail">[E-mail to Staff]</a> <br>
	<a href="/c.html">Copyright &copy; 2008 IEEE</a></h5>

</body>
</html>
HTML

{
my $expected_oui = <<"OUI";
00-01-02   (hex)		3COM CORPORATION
000102     (base 16)		3COM CORPORATION
				5400 Bayfront Plaza  - MS: 4220
				Santa Clara CA 95052
				UNITED STATES
OUI

my $oui = Net::MAC::Vendor::extract_oui_from_html( $html, '00-01-02' );
is( $oui, $expected_oui, "Extracted OUI" );
}

}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Something that works
{
local *STDERR;
open STDERR, ">", \my $output;
my $oui = Net::MAC::Vendor::extract_oui_from_html( '' );
is( $oui, undef, "Get back undef for bad HTML" );
}

#!/use/bin/perl -w

use strict;
use Test::More;
BEGIN {
	my $add = 0;
	eval {require Test::NoWarnings;Test::NoWarnings->import; ++$add; 1 }
		or diag "Test::NoWarnings missed, skipping no warnings test";
	plan tests => 27 + $add;
	eval {require Data::Dumper;Data::Dumper::Dumper(1)}
		and *dd = sub ($) { Data::Dumper->new([$_[0]])->Indent(0)->Terse(1)->Quotekeys(0)->Useqq(1)->Purity(1)->Dump }
		or  *dd = \&explain;
}

use Devel::Hexdump;

=for rem
	if ((key = hv_fetch(conf, "row", 3, 0)) && SvIOK(*key))  cf.row = SvIV(*key);
	if ((key = hv_fetch(conf, "hpad", 4, 0)) && SvIOK(*key)) cf.hpad = SvIV(*key);
	if ((key = hv_fetch(conf, "cpad", 4, 0)) && SvIOK(*key)) cf.cpad = SvIV(*key);
	if ((key = hv_fetch(conf, "hsp", 3, 0)) && SvIOK(*key))  cf.hsp = SvIV(*key);
	if ((key = hv_fetch(conf, "csp", 3, 0)) && SvIOK(*key)) cf.csp = SvIV(*key);
	if ((key = hv_fetch(conf, "cols", 4, 0)) && SvIOK(*key)) cf.cols = SvIV(*key);
=cut

#is xd("\0\0", { row => 2, col => 1 }), "[0000]   00 00".(" "x48).".. \n";
### tests for perl/Tk FcyEntry widget
###
### $Source: t/fcyentry.t $ $Revision: 1.2 $

# About the tests:  Biggest miss is that only simple flow is checked.
#		    But this means only that the code is not verified
#		    to work for any non trival usage :-(

require 't/TESTsetup';

$| = 1;
my $verbose = 1;

use vars '$parent';
$parent = testarea('8');

use Tk::FcyEntry;	# replace std entry
use strict;


######## creation ########

my $xe = $parent->Entry();
ok(defined $xe);
ok(defined $xe->pack(-fill=>'x'));

######## methods ##########

{
  print "# method tests...\n" if $verbose;

  $xe->delete(0,'end');
  ok("" eq $xe->get);
  $xe->insert(0,'foo');
  ok("foo" eq $xe->get);
  $xe->insert(0, 'a');
  ok("afoo" eq $xe->get);
  $xe->insert('end','bar');
  ok("afoobar" eq $xe->get);
}

######## options ##########

{
  print "# -color tests...\n" if $verbose;

  eval { $xe->cget('-editcolor') };
  ok (not $@);
  ok ( $xe->cget('-editcolor') ne $xe->cget('-background') );

#  print "# -status tests...\n" if $verbose;
#  print STDERR "failure of next test is a known misfeature :-(\n";
#  ###  -background (and -editcolor) return same regardless of
#  ### -state same value.  So semantic to query 'real' back
#  ### ground is not known
#
#  $xe->configure(-state => 'disabled');
#  my $d_bg = $xe->cget('-background');
#  $xe->configure(-state => 'normal');
#  my $n_bg = $xe->cget('-background');
#  if ($n_bg ne $d_bg) {
#	ok(1);
#  } else {
#	print "# Why bg color '$n_bg' same for 'normal' and disabled'??\n";
#	ok(0)
#  }

}

testend();

1;
__END__

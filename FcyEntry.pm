### $Source: FcyEntry.pm $ $Revision: 1.3 $
###
### Entry with bg color depending on state. POD after __END__

use strict;

package Tk::FcyEntry;

require Tk;
require Tk::Widget;
require Tk::Derived;
require Tk::Entry;

use vars qw(@ISA $VERSION);
@ISA = qw(Tk::Derived Tk::Entry);
$VERSION = substr q$Revision: 1.3 $, 10;

{
 local($^W)=0;  # suppress Entry overriden warning
 Construct Tk::Widget 'Entry';
}

sub Populate
  {
    my ($w,$args) = @_;

    $w->ConfigSpecs(
	'-state',     => ['METHOD',  qw(state       State        normal) ],
	'-editcolor'  => ['PASSIVE', qw(editColor   EditColor),  Tk::WHITE()],
	'-background' => ['PASSIVE', qw(background  Background), Tk::NORMAL_BG()],
	'-foreground' => ['PASSIVE', qw(foreground  Foreground), Tk::BLACK()],
	'DEFAULT'     => ['SELF'],
	);
    $w;
};

sub state {
    my ($w) = shift;
    if (@_) {
        my $state = shift;
        if ($state eq 'normal') {
	    $w->Tk::Entry::configure(-background => $w->{Configure}{-editcolor});
	    $w->Tk::Entry::configure(-foreground => $w->{Configure}{-foreground});
        } else {
            $w->Tk::Entry::configure(-background => $w->{Configure}{-background});
	    $w->Tk::Entry::configure(-foreground => Tk::DISABLED());
        }
    	$w->Tk::Entry::configure(-state => $state);
    } else {
        $w->Tk::Entry::cget('-state');
    }
};

1;

__END__

=head1 NAME

Tk::FcyEntry - Entry that reflects its state in the background color


=head1 SYNOPSIS

  use Tk;
  use Tk::FcyEntry;	# replaces the standard Entry widget
  ...
  $fcye = $w->Entry( ... everything as usual ... );
  ...


=head1 DESCRIPTION

B<FcyEntry> is like a normal L<Entry|Tk::Entry> widget except:

=over 4

=item *

default background color is 'white'

=item *

if the state of the widget is disabled the background color is set
to be the same as the normal background and the foreground used is
the same as the disabledForeground of a button. (xxx: still not true,
values hardcoded)

=back


=head1 BUGS

background configuration honoured after next state change.

=head1 SEE ALSO

L<Tk|Tk>
L<Tk::Entry|Tk::Entry>

=head1 KEYWORDS

entry, widget, editcolor

=head1 AUTHOR

Achim Bohnet <F<ach@mpe.mpg.de>>

Copyright (c) 1997-1998 Achim Bohnet. All rights reserved.  This
program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


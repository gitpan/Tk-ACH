## $Source: FileEntry.pm $ $Revision: 1.4 $
###
### Primitive FileEntry widget. POD after __END__

package Tk::FileEntry;
use strict;

sub printargs {
    print join('|', map { $_ = '(undef)' unless defined $_ } @_, "\n");
}

require Tk;
require Tk::Widget;
require Tk::Derived;
require Tk::Frame;

use vars qw($VERSION @ISA);
@ISA = qw(Tk::Derived Tk::Frame);
$VERSION = substr q$Revision: 1.4 $, 10;

Construct Tk::Widget 'FileEntry';

my $FILEBITMAP = undef;

sub ClassInit {
    my ($class, $mw) = @_;

    return if defined $FILEBITMAP;  # needed for several MainWindows
    $FILEBITMAP = __PACKAGE__ . '::OPENFOLDER';

    my $bits = pack("b16"x10,
        "...111111.......",
        "..1......11.....",
        ".1.........1....",
        ".1..........1...",
        ".1...11111111111",
        ".1..1.1.1.1.1.1.",
        ".1.1.1.1.1.1.1..",
        ".11.1.1.1.1.1...",
        ".1.1.1.1.1.1....",
        ".1111111111.....",
        );

    $mw->DefineBitmap($FILEBITMAP => 16,10, $bits);

}

sub Populate {
    my ($w,$args) = @_;

    $w->SUPER::Populate($args);

    require Tk::Label;
    require Tk::Entry;
    require Tk::Button;

    my $l = $w->Label()->pack(-side=>'left');
    my $e = $w->Entry()->pack(-side=>'left', -expand=>'yes', -fill=>'x');
    my $b = $w->Button(-command=>[\&_selectfile, $w, $e],-takefocus=>0)
		->pack(-side=>'left',-fill=>'y');

    $e->bind('<Return>', [$w, '_invoke_command', $e]);

    $w->Advertise('entry' => $e);
    $w->Advertise('button' => $b);

    $w->ConfigSpecs(

	    -background	=> [qw(CHILDREN background Background), Tk::NORMAL_BG()],
	    -foreground	=> [qw(CHILDREN foreground Foreground), Tk::BLACK()    ],
	    -state 	=> [qw(CHILDREN state      State        normal)        ],
	    -label       => [{-text => $l},   'label',      'Label',     'File:'],
	    -filebitmap  => [{-bitmap => $b}, 'fileBitmap', 'FileBitmap', $FILEBITMAP,],
	    -command	 => ['CALLBACK',       undef,        undef,       undef],
	    -variable    => ['METHOD',         undef,        undef,       undef],
	    );
    $w;
}


sub _selectfile {
    my $w = shift;
    my $e = shift;

    unless (defined $w->{FSBOX}) {
	require Tk::FileSelect;
	$w->{FSBOX} = $w->FileSelect(); #-directory => '.');
    }
    my $file = $w->{FSBOX}->Show();

    return unless defined $file && length $file;
    $e->delete(0,'end');
    $e->insert('end',$file);
    $w->Callback(-command => $w, $file);
}

sub _invoke_command {
    my $w = shift;
    my $e = shift;
    my $file = $e->get();
    return unless defined $file && length $file;
    $w->Callback(-command => $w, $e->get);
}

sub variable {
    my $e = shift->Subwidget('entry');
    my $v = shift;
    $e->configure(-textvariable => $v);
}    

1;

__END__

=head1 NAME

Tk::FileEntry - FileEntry widget with optional file selection box

=head1 SYNOPSIS

    use Tk::FileEntry;

    $fileentry = $parent->FileEntry(
				-filebitmap	=> BITMAP,
				-command	=> CALLBACK,
				-variable	=> SCALARREF,
				);

=head1 DESCRIPTION


=head1 WIDGET-SPECIFIC OPTIONS

=over 4

=item C<Option:> B<-filebitmap>

=item C<Name:> B<fileBitmap>

=item C<Class:> B<FileBitmap>

Specifies the bitmap to be used for the button that invokes the File Dialog.

=item B<-command>

...

=item B<-variable>

...

=back


=head1 BUGS

If B<FileEntry> is resized to a value smaller than at creation time the
Openfile Bitmap vanishes.

FileSelection of alpha release Tk800.003 does not work (my fault!).
So FileEntrys FileSelction dialog will not work with this release.

=head1 SEE ALSO

L<Tk|Tk>
L<Tk::Entry|Tk::Entry>
L<Tk::FileSelect|k::FileSelect>

=head1 KEYWORDS

fileentry, tix, widget, file selector

=head1 AUTHOR

Achim Bohnet <F<ach@mpe.mpg.de>>

This code is inspired by the documentation of FileEntry.n of
the Tix4.1.0 distribution by Ioi Lam.  The bitmap data are
also from Tix4.1.0.  For everything else:

Copyright (c) 1997-1998 Achim Bohnet. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut


use ExtUtils::MakeMaker;

WriteMakefile(
	PREREQ_PM	=> {
			     ExtUtils::MakeMaker => '5.41',   # for #! fixing
			     Tk => '402.002',		      # opt. aliases
			   },

	DISTNAME	=> 'Tk-ACH',
        NAME		=> 'Tk::ACH',
	VERSION		=> '0.04',

	DIR		=> [],
	EXE_FILES	=> [ 'ptktrl' ],

	linkext		=> { LINKTYPE => '' },
	dist		=> { COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
);

__END__


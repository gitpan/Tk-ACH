use ExtUtils::MakeMaker;

require Tk;
if ($Tk::VERSION eq '800.003')
  {
    print <<EOT;

	Uppps you're using the alpha release Tk V$Tk::VERSION: 
	FileSelection of this perl/Tk release does not work
	(my fault!).  So FileEntrys FileSelction dialog will also
	not work.

EOT
  }

WriteMakefile(
	PREREQ_PM	=> {
			     ExtUtils::MakeMaker => '5.41',   # for #! fixing
			     Tk => '402.002',		      # opt. aliases
			   },

	DISTNAME	=> 'Tk-ACH',
        NAME		=> 'Tk::ACH',
	VERSION		=> '0.02',

	DIR		=> [],
	EXE_FILES	=> [ 'ptksh' ],

	linkext		=> { LINKTYPE => '' },
	dist		=> { COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
);

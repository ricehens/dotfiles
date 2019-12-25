$pdf_mode = 1;
$max_repeat = 7;
$pdf_previewer = "zathura %O %S &";

$latex = 'latex -interaction=nonstopmode -shell-escape';
$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape';

$cleanup_includes_generated = 0;
$cleanup_includes_cusdep_generated = 1;

@generated_exts = ( 'aux', 'bbl', 'bcf', 'fls', 'idx', 'ind', 'lof',
                    'lot', 'out', 'pre', 'toc', 'nav', 'snm', 'von', 'mcgrep');

# don't hash calc for deep system dependencies
$hash_calc_ignore_pattern{'map'} = '^';
$hash_calc_ignore_pattern{'fmt'} = '^';

##### ASYMPTOTE SETUP #####
## OLD simple method (taken from the documentation for V. 2.03 of
## asymptote).  These definitions are simple, but they may not always
## give the desired type of output file, and they do not ensure that
## latexmk has dependency information about files imported from the
## asy file.
#OLD sub asy {return system("asy \"$_[0]\"");}
#OLD add_cus_dep("asy","eps",0,"asy");
#OLD add_cus_dep("asy","pdf",0,"asy");
#OLD add_cus_dep("asy","tex",0,"asy");


# The following definitions arrange to run asy with the correct output
# file type.  They run asy in a verbose mode so that dependency
# information on imported files can be extracted.  To avoid adding a
# lot of extra printout on the screen of unimportant messages, the
# output is sent to a log file.  Since this includes error messages,
# which the user should see, latexmk types out error messages and the
# like. These definitions need latexmk 4.48 or later.

add_cus_dep("asy","eps",0,"asy2eps");
add_cus_dep("asy","pdf",0,"asy2pdf");
add_cus_dep("asy","tex",0,"asy2tex");

sub asy2eps { return asy2x( $_[0], 'eps' ); }
sub asy2pdf { return asy2x( $_[0], 'pdf' ); }
sub asy2tex { return asy2x( $_[0], 'tex' ); }

sub asy2x   {
# Add the tag -nosafe for ghostscript 9.24 through 9.27 (fixed in 9.50!)
   my $ret = system("asy -noprc -render=0 -vv -f '$_[1]' '$_[0]' >& '$_[0].log'");
   my $FH = new FileHandle;
   open $FH, "$_[0].log";
   %imp = ();

   while (<$FH>) { if (/^(Including|Loading) .* from (.*)\s*$/) { my $import = $2; $imp{$import} = 1;}
       elsif ( /^error/ || /^.*\.asy: \d/ ) {
           warn "==Message from asy: $_";
	   $ret = 1;
       }
       elsif ( /^kpsewhich / || /^Processing / || /^Using /
               || /^Welcome / || /^Wrote /|| /^cd /|| /^gs /
	     ) {
       }
       else {
           warn "==Message from asy: $_";
       }
   }
   close $FH;
# For latexmk 4.48
   if ($version_num >= '4.48') {
       rdb_set_source( $rule, keys %imp );
   }
   return $ret;
}

sub von_run { return system("bash '$_[0].von'"); }
add_cus_dep("von", "out", 0, "von_run");

sub mcgrep_run { return system("bash '$_[0].mcgrep'"); }
add_cus_dep("mcgrep", "out", 0, "mcgrep_run");

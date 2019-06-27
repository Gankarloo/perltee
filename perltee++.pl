#!/usr/bin/env perl
use strict;
use warnings;
use POSIX;

if (@ARGV == 0){die "specify logfile";}

open(my $log, ">>", $ARGV[0]) or die;
while (<STDIN>) {print $_;
    my $TST = strftime "[%Y-%m-%d %H:%M:%S] ", localtime;
    $_ =~ s/\e[\[\(][0-9;]*[mGKFB]//g;
    my $line = $TST . $_;
    print $log $line;
};

# regex remove escape chars
#perl -pe 's/\e[\[\(][0-9;]*[mGKFB]//g'
#exec 1> >(perl -e 'use POSIX;if (@ARGV == 0){die "specify logfile";}open(my $log, ">>", $ARGV[0]) or die;while (<STDIN>) {print $_;my $TST = strftime "[%Y-%m-%d %H:%M:%S] ", localtime;$_ =~ s/\e[\[\(][0-9;]*[mGKFB]//g;my $line = $TST . $_;print $log $line;}' "${LOGFILE}") 2>&1

# Perl Tee ++
## Description
perltee++ works as the 'tee' program  
it sends STDOUT to both STDOUT and a logfile.  

### the ++ part
* prepends a timestamp to each line.
* removes any color coding escape chars, we want an uncluttered logfile.

## Usage
### One Liner in bash script  
```bash
#!/bin/bash
SCRIPTDIR=$(dirname "$(readlink -f "${0}")")
LOGFILE=${SCRIPTDIR}/$(basename "${0}").log

exec 1> >(perl -e 'use POSIX;if (@ARGV == 0){die "specify logfile";}open(my $log, ">>", $ARGV[0]) or die;while (<STDIN>) {print $_;my $TST = strftime "[%Y-%m-%d %H:%M:%S] ", localtime;$_ =~ s/\e[\[\(][0-9;]*[mGKFB]//g;my $line = $TST . $_;print $log $line;}' "${LOGFILE}") 2>&1

...
rest of script
```
Dont forget to assign a filename to ${LOGFILE}

This will capture all output from the script.

### Same onliner split on multiple lines for readability
```bash
exec 1> >(perl -e 'use POSIX;
	if (@ARGV == 0){die "specify logfile";}
	open(my $log, ">>", $ARGV[0]) or die;
	while (<STDIN>) {
		print $_;
		my $TST = strftime "[%Y-%m-%d %H:%M:%S] ", localtime;
		$_ =~ s/\e[\[\(][0-9;]*[mGKFB]//g;
		my $line = $TST . $_;
		print $log $line;
	}' "${LOGFILE}") 2>&1.
```
### As a separate script in a bash script.
```bash
exec 1> >(../perltee++/perltee++.pl "${LOGFILE}") 2>&1
```

Prettier, but now you need to make sure the preltee++ script is available.

### As a simple pipe
``` bash
somescript | perltee++ logfile.log
```

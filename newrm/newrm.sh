#!/bin/bash

archive_dir="$HOME/.deleted-files"
real_rm="$(which rm)"
copy="$(which cp)"

# Let the real rm output the error message
if [ $# -eq 0 ]; then
	exec $real_rm
fi

# Parse all options looking for -f
flags=""

while getopts "dfiPRrvW" opt
do
	case $opt in
		f ) exec $real_rm "$@"		;; # in case -f flag is used run the real rm
		* ) flags="$flags -$opt"	;; # the rest of the flags are for rm 
	esac
	shift $(( $OPTIND - 1 ))
done

# BEGIN MAIN SCRIPT
# =================

# Make sure the $archive_dir exists
if [ ! -d $archive_dir ]; then
	if [ ! -w $HOME ]; then
		echo "$0 failed: can't create $archive_dir in $HOME" >&2
		exit 1
	fi
	mkdir $archive_dir
	chmod 700 $archive_dir # r,w,x only for user, nothing for the rest
fi


for arg
do
	newname="$archive_dir/$(date "+%S.%M.%H.%d.%m").$(basename "$arg")"
	if [ -f "$arg" -o -d "$arg" ]; then
		$copy "$arg" "$newname"
	fi
done

# Our shell is replaced by real_rm
exec $real_rm $flags "$@"

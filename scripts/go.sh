#!/bin/bash
#
# The main script that kicks off data collection on the perf
# server. It is meant to be run from the "benchmarks/scripts"
# directory.

MYDIR=$(dirname $0)

# Load the various directories and so forth.
source "$MYDIR/dirs.sh"

while :; do
    $SCRIPTS_DIR/time.sh
done

#!/bin/bash
#
# Pulls current rust and tracks the last version that we have
# seen. When we see a new version, starts `run_bench.sh` to benchmark
# it.

MYDIR=$(dirname $0)
source "$MYDIR/dirs.sh"

cd $RUST_DIR

echo "pulling master ($DATE)"
git checkout master
git pull upstream master

# write the commit-stamp
mv nrc.stamp nrc.stamp.old
git log -1 --format="%H" >nrc.stamp
while cmp -s nrc.stamp nrc.stamp.old
do
    echo "sleeping"
    sleep 1h
    git pull upstream master
    git log -1 --format="%H" >nrc.stamp
done

export DATE=$(date +%F-%H-%M-%S)
$SCRIPTS_DIR/run_bench.sh

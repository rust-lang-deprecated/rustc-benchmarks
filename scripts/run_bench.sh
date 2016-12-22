#!/bin/bash
# Benchmarks currently checked out Rust.

TIMES_DIR=/root/times
BENCH_DIR=/root/benchmarks
SCRIPTS_DIR=/root/times-scripts

START=$(pwd)

echo "building"

./configure
make rustc -j8

export RUSTFLAGS_STAGE2="-Ztime-passes -Zinput-stats"

for i in 0 1 2
do
    echo "building, round $i"
    git show HEAD -s >$TIMES_DIR/raw/rustc--$DATE--$i.log
    touch src/librustc_trans/lib.rs
    make >>$TIMES_DIR/raw/rustc--$DATE--$i.log
done

echo "processing data"
cd $TIMES_DIR
python $SCRIPTS_DIR/process.py rustc $DATE 3
for i in 0 1 2
do
    git add raw/rustc--$DATE--$i.log
done
git add processed/rustc--$DATE.json

echo "benchmarks"
export RUSTC_DIR=$START/x86_64-unknown-linux-gnu/stage2
export RUSTC=$RUSTC_DIR/bin/rustc
export LD_LIBRARY_PATH=$RUSTC_DIR/lib
export RUST_DIR=$START
cd $BENCH_DIR
./process.sh

echo "committing"
cd $TIMES_DIR
git commit -m "Added data for $DATE"
git push upstream master

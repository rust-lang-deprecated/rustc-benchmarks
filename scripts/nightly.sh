# Nightly archives are at: http://static.rust-lang.org/dist/index.html

# Runs all the benchmarking for a single downloaded nightly for SRC_DATE

SRC_DATE=2015-05-13

TIMES_DIR=/home/ncameron/times
BENCH_DIR=/home/ncameron/benchmarks
SCRIPTS_DIR=/home/ncameron/times-scripts

mkdir $SRC_DATE
cd $SRC_DATE

echo "downloading nightly for $SRC_DATE"
curl -s http://static.rust-lang.org/dist/$SRC_DATE/rustc-nightly-src.tar.gz | tar -xz

cd rustc-nightly

START=$(pwd)


echo "building"

./configure
make rustc-stage1 -j8

export RUSTFLAGS_STAGE2=-Ztime-passes
export DATE=$SRC_DATE-00-00

for i in 0 1 2
do
    echo "building, round $i"
    echo "commit 000000" >$TIMES_DIR/raw/rustc--$DATE--$i.log
    echo "Author NA" >>$TIMES_DIR/raw/rustc--$DATE--$i.log
    echo "Date:   $SRC_DATE" >>$TIMES_DIR/raw/rustc--$DATE--$i.log
    touch src/librustc_trans/trans/mod.rs
    make >>$TIMES_DIR/raw/rustc--$DATE--$i.log
done

echo "processing data"
cd $TIMES_DIR
python $SCRIPTS_DIR/process.py rustc $DATE 3
for i in 0 1 2
do
    git add raw/rustc--$DATE--$i.log
    git add processed/rustc--$DATE--$i.json
done

echo "benchmarks"
export RUSTC_DIR=$START/x86_64-unknown-linux-gnu/stage2
export RUSTC=$RUSTC_DIR/bin/rustc
export LD_LIBRARY_PATH=$RUSTC_DIR/lib
cd $BENCH_DIR
./process.sh

echo "committing"
cd $TIMES_DIR
git commit -m "Added data for nightly $SRC_DATE"
git push origin master

echo "tidying up"
cd $START
cd ../..
rm -rf $SRC_DATE

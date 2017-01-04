#!/bin/bash
#
# Using the rustc executable found in $RUSTC_DIR (as set by
# `scripts/dirs.sh`), executes each of the benchmarks found in this
# directory. See the README.md for comments on the protocol.

MYDIR=$(dirname $0)
source "$MYDIR/scripts/dirs.sh"

export CARGO_RUSTC_OPTS="-Ztime-passes -Zinput-stats"
export PATH=$RUSTC_DIR/bin:$PATH

echo TIMES_DIR=$TIMES_DIR
echo SCRIPTS_DIR=$SCRIPTS_DIR

# Check if user provided list of directories;
# else process them all.
cd $BENCH_DIR
if [ "$1" != "" ]; then
    DIRS="$@"
else
    DIRS="*"
fi    

for dir in $DIRS; do
    if [[ -d $dir ]]; then
        echo "Processing $dir"

        cd $BENCH_DIR/$dir
        PATCHES=($(make patches))
        if [ ! "${PATCHES[*]}" ]; then
            PATCHES=('')
        fi

        echo Patches: ${PATCHES[*]}

        for i in 0 1 2 3 4 5
        do
            for PATCH in "${PATCHES[@]}"; do
                cd $RUST_DIR
                git show HEAD -s >$TIMES_DIR/raw/$dir$PATCH--$DATE--$i.log
                rustc --version >>$TIMES_DIR/raw/$dir$PATCH--$DATE--$i.log
                ls -l $(which rustc) >>$TIMES_DIR/raw/$dir$PATCH--$DATE--$i.log
                cd $BENCH_DIR/$dir
                echo "rustc: ./$dir$PATCH" >>$TIMES_DIR/raw/$dir$PATCH--$DATE--$i.log
                make all$PATCH >>$TIMES_DIR/raw/$dir$PATCH--$DATE--$i.log
                echo "done" >>$TIMES_DIR/raw/$dir$PATCH--$DATE--$i.log
            done
            make touch >/dev/null
        done

        make clean >/dev/null

        cd $TIMES_DIR
        for PATCH in "${PATCHES[@]}"; do
            python $SCRIPTS_DIR/process.py "$dir$PATCH" "$DATE" 6
        done

        for PATCH in "${PATCHES[@]}"; do
            for i in 0 1 2 3 4 5
            do
                git add "raw/$dir$PATCH--$DATE--$i.log"
            done

            git add "processed/$dir$PATCH--$DATE.json"
        done

        cd $BENCH_DIR
    fi
done

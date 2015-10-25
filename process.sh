TIMES_DIR=/home/ncameron/times
SCRIPTS_DIR=/home/ncameron/times-scripts

START=$(pwd)
export CARGO_BUILD="cargo rustc -- -Ztime-passes"
export PATH=$RUSTC_DIR/bin:$PATH

for dir in *; do
    if [[ -d $dir ]]; then
        echo "Processing $dir"
        cd $dir
        for i in 0 1 2 3 4 5
        do
            rustc --version >$TIMES_DIR/raw/$dir--$DATE--$i.log
            echo "rustc: ./$dir" >>$TIMES_DIR/raw/$dir--$DATE--$i.log
            make >>$TIMES_DIR/raw/$dir--$DATE--$i.log
            echo "done" >>$TIMES_DIR/raw/$dir--$DATE--$i.log

            make touch >/dev/null
        done
        make clean >/dev/null

        cd $TIMES_DIR
        python $SCRIPTS_DIR/process.py $dir $DATE 6
        for i in 0 1 2 3 4 5
        do
            git add raw/$dir--$DATE--$i.log
            git add processed/$dir--$DATE--$i.json
        done

        cd $START
    fi
done

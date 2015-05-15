DATE=$(date +%F)
START=$(pwd)

for dir in *; do
    if [[ -d $dir ]]; then
        echo "Processing $dir"
        cd $dir
        for i in 0 1 2 3 4 5
        do
            rustc --version >/home/ncameron/times/raw/$dir-$DATE-$i.log
            echo "rustc: ./$dir" >>/home/ncameron/times/raw/$dir-$DATE-$i.log
            make >>/home/ncameron/times/raw/$dir-$DATE-$i.log
            echo "done" >>/home/ncameron/times/raw/$dir-$DATE-$i.log

            make clean >/dev/null
        done

        cd /home/ncameron/times
        python process.py $dir $DATE 6
        for i in 0 1 2 3 4 5
        do
            git add raw/$dir-$DATE-$i.log
            git add processed/$dir-$DATE-$i.json
        done

        cd $START
    fi
done

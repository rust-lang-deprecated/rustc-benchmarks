.PHONY: all touch clean

all:
	cargo rustc --test all --verbose -- -Ztime-passes -Zinput-stats
touch:
	rm -f target/debug/all-*
clean:
	rm target -rf
	rm Cargo.lock

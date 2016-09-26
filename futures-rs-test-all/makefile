.PHONY: all touch clean

all:
	cargo rustc --test all --verbose -- -Ztime-passes -Zinput-stats
touch:
	rm -rf target/debug
clean:
	rm target -rf
	rm Cargo.lock

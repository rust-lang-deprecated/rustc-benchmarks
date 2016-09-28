.PHONY: all touch clean

all:
	RUSTFLAGS="-Z incremental=incr -Z incremental-info" cargo rustc -- $(CARGO_RUSTC_OPTS)
touch:
	cargo clean # note: leave the `incr` directory alone
clean:
	rm -rf incr/*
	cargo clean
	rm Cargo.lock

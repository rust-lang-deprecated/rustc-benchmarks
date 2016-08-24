all:
	RUSTFLAGS="-Z incremental=incr -Z incremental-info" $(CARGO_BUILD)

touch:
	cargo clean # note: leave the `incr` directory alone

clean:
	rm -rf incr/*
	cargo clean

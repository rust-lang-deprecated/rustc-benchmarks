.PHONY: all touch clean

# The way that this is intended to work is as follows:
# - We force the incremental data to be stored in the `incr` directory
# - We clean precisely the syntex_syntax crate; but we do not touch the `incr` directory
# - We rebuild, which will reuse the results from `incr` directory
#
# This can be compared against `syntex-0.42.2`, which does the same
# thing, but without the `incr` directory.

all:
	RUSTFLAGS="-Z incremental=incr" \
	    cargo rustc -p syntex_syntax -- $(CARGO_RUSTC_OPTS) -Z incremental-info
touch:
	cargo clean -p syntex_syntax
clean:
	rm -rf incr/*
	cargo clean

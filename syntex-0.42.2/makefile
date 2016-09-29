.PHONY: all touch clean

# Time how long it takes to build `syntex_syntax`. See
# `../syntax-0.42.2-incr-clean/makefile` for some further notes.

all:
	cargo rustc -p syntex_syntax -- $(CARGO_RUSTC_OPTS)
touch:
	cargo clean -p syntex_syntax
clean:
	cargo clean

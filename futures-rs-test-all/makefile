.PHONY: all touch clean

all:
	cargo rustc --test all -- $(CARGO_RUSTC_OPTS)
touch:
	rm -f target/debug/all-*
clean:
	cargo clean

.PHONY: all touch clean

all:
	cargo rustc --test all -- $(CARGO_RUSTC_OPTS)
touch:
	rm -f target/debug/all-*
clean:
	rm target -rf
	rm Cargo.lock

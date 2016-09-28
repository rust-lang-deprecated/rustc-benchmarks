.PHONY: all touch clean

all:
	cargo rustc -- $(CARGO_RUSTC_OPTS)
touch:
	find . -name '*.rs' | xargs touch
clean:
	cargo clean
	rm Cargo.lock

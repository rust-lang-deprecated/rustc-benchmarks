.PHONY: all touch clean

all:
	cargo rustc $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS)
touch:
	find . -name '*.rs' | xargs touch
clean:
	cargo clean

.PHONY: all touch clean

all:
	cargo rustc --test all $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS)
touch:
	rm -rf target/debug
clean:
	cargo clean
patches:
	@echo ''

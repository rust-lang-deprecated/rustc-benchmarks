.PHONY: all touch clean

# Time how long it takes to build `syntex_syntax`. See
# `../syntax-0.42.2-incr-clean/makefile` for some further notes.

all@000-base:
	cargo rustc -p syntex_syntax $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS)
all@010-incr:
	find . -name '*.rs' | xargs touch
	RUSTFLAGS="-Z incremental=incr" \
	    cargo rustc -p syntex_syntax $(CARGO_OPTS) -- \
	    $(CARGO_RUSTC_OPTS) -Z incremental-info
all@020-clean:
	find . -name '*.rs' | xargs touch
	RUSTFLAGS="-Z incremental=incr" \
	    cargo rustc -p syntex_syntax $(CARGO_OPTS) -- \
	    $(CARGO_RUSTC_OPTS) -Z incremental-info
touch:
	find . -name '*.rs' | xargs touch
	rm -rf incr
clean:
	cargo clean
patches:
	@echo '@000-base @010-incr @020-clean'

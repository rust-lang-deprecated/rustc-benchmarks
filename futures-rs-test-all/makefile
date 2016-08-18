.PHONY: all touch clean

all:
	$(CARGO_BUILD) --test all
touch:
	rm -f target/debug/all-*
clean:
	rm target -rf
	rm Cargo.lock

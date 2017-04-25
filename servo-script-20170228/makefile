.PHONY: all touch clean measure

DATE=$(shell date '+%Y-%m-%d')

all:
	echo "try `make measure` etc"

measure:
	@for N in clean all@000-dev all@010-dev-incr all@020-dev-touch-style all@030-dev-d007eef5; \
	do echo ${DATE}: running '`'make $$N'`' ; \
	make CARGO_RUSTC_OPTS=-Ztime-passes $$N > measurements.${DATE}.$$N 2>&1 ; \
	tail -1 measurements.${DATE}.$$N ; \
	done

all@000-dev:
	./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS)

all@010-dev-incr:
	RUSTFLAGS="-Zincremental=$PWD/incr" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

all@020-dev-touch-style:
	touch components/style/lib.rs
	RUSTFLAGS="-Zincremental=$PWD/incr" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

# "Unapply" an existing servo commit to try to measure
# the effect of a realistic change.
all@030-dev-d007eef5:
	patch -R -p1 < d007eef5.patch 
	RUSTFLAGS="-Zincremental=$PWD/incr" \
		./mach cargo -- rustc -p script $(CARGO_OPTS) -- $(CARGO_RUSTC_OPTS) -Zincremental-info

touch:
	find . -name '*orig' -delete
	find . -name '*pyc' -delete
	git checkout components
	rm -rf incr
	./mach cargo -- clean -p script

clean: touch
	./mach clean

patches:
	@echo \
		"@000-dev" \
		"@010-dev-incr" \
		"@020-dev-touch-style" \
		"@030-dev-d007eef5"

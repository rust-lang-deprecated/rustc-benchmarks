# Benchmarks for Rust compiler performance

Each subdirectory contains a single benchmark. Although benchmarks may contain
multiple crates, each benchmark has one "crate of interest" which is the one
whose compilation time is measured.

Each benchmark has a makefile with the following targets.
* `all`: builds the entire benchmark. The `CARGO_RUSTC_OPTS` environment
  variable can be specified to pass extra arguments to rustc invocations.
* `touch`: touches or removes files in such a way that a subsequent `make`
  invocation will build only the crate of interest.
* `clean`: removes all build artifacts.

A historical record of timings is shown at: http://perf.rust-lang.org/. This
site makes use of the `process.sh` script plus some auxiliary scripts not in
this repository.

Local runs comparing two different compilers can be performed with
`compare.py`. This is useful when evaluating compile-time optimizations.


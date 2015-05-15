# Benchmarks for Rust compiler performance

Each subdirectory should contain a crate for benchmarking. It should include a
makefile so that the crate can be built by running `make`. Any use of rustc
should include the argument `-Ztime-passes`. See for example the helloworld
crate.

Perhaps should use $RUSTC then can use our own compiler and set -Ztime-passes

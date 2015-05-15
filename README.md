# Benchmarks for Rust compiler performance

Each subdirectory should contain a single crate for benchmarking. It should
include a makefile so that the crate can be built by running `make`. Any use of
rustc should include the argument `-Ztime-passes`. See for example the
helloworld crate. Each makefile should build only one crate.

Perhaps should use $RUSTC then can use our own compiler and set -Ztime-passes

regex is duplicated because there are two crates, and the current scipt only
handles one crate per directory. It would be better to have a manifest or something.

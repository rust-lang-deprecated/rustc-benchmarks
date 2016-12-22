# Script for setting up the timing server (bound to be incomplete)

# install prereqs
apt-get install git
apt-get install libssl-dev
# TODO there were other prereqs

# install Rust and Cargo
curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- --channel=nightly

# pull repos
mkdir testing
cd testing
git clone https://github.com/nrc/testing.git .
cd ..

mkdir times
cd times
git clone https://github.com/nrc/rustc-timing.git .
cd ..

mkdir times-scripts
cd times-scripts
git clone https://github.com/nrc/rustc-timing-scripts.git .
cd ..

mkdir benchmarks
cd benchmarks
git clone https://github.com/nrc/benchmarks.git .
cd ..

mkdir rust
cd rust
git clone https://github.com/rust-lang/rust.git .
cd ..

# Create some dirs
mkdir nightlies
cd times
mkdir raw
mkdir processed
cd ..

# Copy scripts
cd testing
cp process.sh ~/benchmarks/
cp nightly.sh ~/nightlies/
cp time.sh ~/rust/
cd ..

# Setup GitHub user
git config --global user.name "$USERNAME"
git config --global user.email "$EMAIL"
git config --global credential.helper store

# You'll need to push something at least once to store the username and password for the GH account

# Note that this setup uses origin rather than upstream for the times committing scripts.

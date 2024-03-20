# Do everything.
all: init brew link

# Set initial preference.
init:
	./bin/setup.sh

brew:
	./bin/brew.sh

link:
	./bin/link.sh

defaults:
	./bin/defaults.sh

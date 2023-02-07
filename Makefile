# Do everything.
all: init link

# Set initial preference.
init:
	./bin/setup.sh

link:
	./bin/link.sh

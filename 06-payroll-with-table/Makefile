COBFLAGS = -Wall

run: build
	COB_LIBRARY_PATH=lib ./bin/main

build: clean
	mkdir -p bin lib
	cobc $(COBFLAGS) -m -o lib/summary.dylib src/summary.cob
	cobc $(COBFLAGS) -x -o bin/main src/main.cob

clean:
	rm -rf bin lib

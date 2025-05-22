COBFLAGS = -Wall

run: build
	COB_LIBRARY_PATH=lib ./bin/age-check

build: clean
	mkdir -p bin lib
	cobc $(COBFLAGS) -x -o bin/age-check src/age-check.cob

clean:
	rm -rf bin lib

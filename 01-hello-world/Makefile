COBFLAGS = -Wall

run: build
	COB_LIBRARY_PATH=lib ./bin/hello

build: clean
	mkdir -p bin lib
	cobc $(COBFLAGS) -x -o bin/hello src/hello.cob

clean:
	rm -rf bin lib

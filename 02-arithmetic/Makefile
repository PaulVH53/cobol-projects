COBFLAGS = -Wall

run: build
	COB_LIBRARY_PATH=lib ./bin/calculator

build: clean
	mkdir -p bin lib
	cobc $(COBFLAGS) -x -o bin/calculator src/calculator.cob

clean:
	rm -rf bin lib

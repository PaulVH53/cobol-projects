COBFLAGS = -Wall

run: build
	COB_LIBRARY_PATH=lib ./bin/payroll

build: clean
	mkdir -p bin lib output
	cobc $(COBFLAGS) -x -o bin/payroll src/payroll.cob

clean:
	rm -rf bin lib output

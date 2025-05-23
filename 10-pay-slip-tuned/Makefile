# Ruta al módulo COBOL dinámico
COBFLAGS = -Wall

run: build
	@echo ">> Ejecutando aplicación..."
	COB_LIBRARY_PATH=lib ./bin/main

prepare:
	@echo ">> Preparando carpetas..."
	mkdir -p report/payslips

build: clean prepare
	@echo ">> Creando carpetas bin/ y lib/..."
	mkdir -p bin lib
	@echo ">> Compilando payslip.cob como módulo..."
	cobc $(COBFLAGS) -m -o lib/payslip.dylib src/payslip.cob
	@echo ">> Compilando main.cob como ejecutable..."
	cobc $(COBFLAGS) -x -o bin/main src/main.cob

clean:
	@echo ">> Limpiando directorios bin/, lib/ y report/payslips/..."
	rm -rf bin lib
	rm -rf report/payslips/*


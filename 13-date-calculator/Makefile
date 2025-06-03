# Ruta al módulo COBOL dinámico
COBFLAGS = -Wall

run: clean build
	@echo ">> Ejecutando aplicación..."
	COB_LIBRARY_PATH=lib ./bin/main

build: clean
	@echo ">> Creando carpeta bin/..."
	mkdir -p bin
	@echo ">> Compilando main.cob como ejecutable..."
	cobc $(COBFLAGS) -x -o bin/main src/main.cob

clean:
	@echo ">> Limpiando directorio bin/..."
	rm -rf bin


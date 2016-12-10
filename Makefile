all: dagon

CC=cc

dagon: main.c
	${CC} $^ -o $@

.PHONY: clean

clean:
	rm dagon

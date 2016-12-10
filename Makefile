all: dagon

CC=cc

dagon: main.c lex.yy.c
	${CC} $^ -o $@

lex.yy.c: lex.l
	flex lex.l

.PHONY: clean

clean:
	rm dagon

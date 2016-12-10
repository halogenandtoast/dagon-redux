all: dagon

CC=cc
LEX=flex

dagon: main.c
	${CC} $^ -o $@

main.c: lex.yy.c

lex.yy.c: lex.l
	${LEX} lex.l

.PHONY: clean

clean:
	rm dagon

SRC=main.c node.c parse.tab.c lex.yy.c list.c
CC=cc
LEX=flex
YACC=bison

all: dagon

dagon: ${SRC}
	${CC} $^ -o $@

parse.tab.c: parse.y
	${YACC} -t -v -d $<

lex.yy.c: lex.l
	${LEX} --header-file=lex.yy.h $<

.PHONY: clean

clean:
	rm dagon parse.tab.h parse.tab.c lex.yy.c lex.yy.h parse.output

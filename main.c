#include <stdio.h>
#include "lex.yy.c"

int main(int argc, char* argv[]) {
  yyscan_t scanner;
  yylex_init(&scanner);

  if(argc > 1) {
    yyset_in(fopen(argv[1], "rb"), scanner);
  }

  yylex(scanner);
  yylex_destroy(scanner);
  return 0;
}

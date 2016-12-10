#include <stdio.h>
#include "parse.tab.h"
#include "lex.yy.h"

int main(int argc, char* argv[]) {
  yyscan_t scanner;
  yylex_init(&scanner);

  if(argc > 1) {
    yyset_in(fopen(argv[1], "rb"), scanner);
  } else {
    yyset_in(stdin, scanner);
  }

  yyparse(scanner);

  yylex_destroy(scanner);
  return 0;
}

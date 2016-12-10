#include <stdio.h>
#include "dagon.h"
#include "parse.tab.h"
#include "lex.yy.h"

int main(int argc, char* argv[]) {
  yyscan_t scanner;
  yylex_init(&scanner);

  dagon_env env;

  if(argc > 1) {
    yyset_in(fopen(argv[1], "rb"), scanner);
  } else {
    yyset_in(stdin, scanner);
  }

  yyparse(scanner, &env);
  printf("%p\n", env.node);

  yylex_destroy(scanner);
  return 0;
}

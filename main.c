#include <stdio.h>

extern FILE* yyin;
extern int yylex();

int main(int argc, char* argv[]) {
  if(argc > 1) {
    yyin = fopen(argv[1], "r");
  }

  yylex();
  return 0;
}

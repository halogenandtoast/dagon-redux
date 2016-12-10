%{
  #include <stdio.h>
  #include <stdlib.h>
%}

%option noyywrap

%%

. { fprintf(stderr, "Unknown token %s\n", yytext); exit(EXIT_FAILURE); }

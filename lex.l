%{
  #include <stdio.h>
  #include <stdlib.h>

  #define VALUE_TOKEN(type) printf("%s(%s)\n", #type, yytext)
  #define TOKEN(type) printf("%s\n", #type)
%}

%option noyywrap

%%
: { TOKEN(COLON); }
@ { TOKEN(AT); }
\. { TOKEN(DOT); }
\( { TOKEN(LPAREN); }
\) { TOKEN(RPAREN); }
\n { TOKEN(NEWLINE); }
" "
\"[^\"]*\" { VALUE_TOKEN(STRING); }
[A-Z][A-z0-9_]+ { VALUE_TOKEN(CONSTANT); }
[a-z][a-z0-9\-]* { VALUE_TOKEN(ID); }
. { fprintf(stderr, "Unknown token '%s'\n", yytext); exit(EXIT_FAILURE); }

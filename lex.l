%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "dagon.h"
  #include "parse.tab.h"

  #define VALUE_TOKEN(type) return type
  #define TOKEN(type) return type

  static int indented = 0;
  static int previous_indentation = 0;
  static int indentation = 0;
%}

%option noyywrap
%option reentrant
%option bison-bridge
%option yylineno
%option header-file="lex.yy.h"

%s start
%x indent

%%

<indent>\n { indentation = 0; }
<indent>"  " { indentation++; }
<indent>. {
  unput(*yytext);
  if(indentation > previous_indentation) {
    indented = 1;
    previous_indentation++;
    TOKEN(INDENT);
  } else if(indentation < previous_indentation) {
    previous_indentation--;
    TOKEN(DEDENT);
  } else {
    BEGIN INITIAL;
    if(!indented) {
      TOKEN(NEWLINE);
    }
  }
}

": " { TOKEN(ASSIGN); }
: { TOKEN(':'); }
@ { TOKEN('@'); }
\. { TOKEN('.'); }
\( { TOKEN('('); }
\) { TOKEN(')'); }
\n { indented = 0; indentation = 0; BEGIN indent; }
\"[^\"]*\" { VALUE_TOKEN(STRING); }
[A-Z][A-z0-9_]+ { VALUE_TOKEN(CONSTANT); }
[a-z][a-z0-9\-]* { VALUE_TOKEN(ID); }
. { fprintf(stderr, "Unknown token '%s'\n", yytext); exit(EXIT_FAILURE); }

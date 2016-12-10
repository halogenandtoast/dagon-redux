%{
  #include <stdio.h>
  #include <stdlib.h>

  #define VALUE_TOKEN(type) printf("%s(%s)\n", #type, yytext)
  #define TOKEN(type) printf("%s\n", #type)

  static int previous_indentation = 0;
  static int indentation = 0;
%}

%option noyywrap
%option reentrant

%s start
%x indent

%%

<indent>\n { indentation = 0; TOKEN(NEWLINE); }
<indent>"  " { indentation++; }
<indent>. {
  unput(*yytext);
  if(indentation > previous_indentation) {
    previous_indentation++;
    TOKEN(INDENT);
  } else if(indentation < previous_indentation) {
    previous_indentation--;
    TOKEN(DEDENT);
  } else {
    BEGIN INITIAL;
  }
}

": " { TOKEN(ASSIGN); }
: { TOKEN(COLON); }
@ { TOKEN(AT); }
\. { TOKEN(DOT); }
\( { TOKEN(LPAREN); }
\) { TOKEN(RPAREN); }
\n { indentation = 0; BEGIN indent; TOKEN(NEWLINE); }
\"[^\"]*\" { VALUE_TOKEN(STRING); }
[A-Z][A-z0-9_]+ { VALUE_TOKEN(CONSTANT); }
[a-z][a-z0-9\-]* { VALUE_TOKEN(ID); }
. { fprintf(stderr, "Unknown token '%s'\n", yytext); exit(EXIT_FAILURE); }

%{
  #include <stdio.h>
  #include "dagon.h"
  #include "parse.tab.h"
  #include "lex.yy.h"

  void yyerror(yyscan_t scanner, dagon_env* env, char const *msg);
%}

%define parse.error verbose
%define api.pure true

%lex-param {void* scanner}
%parse-param {void* scanner}
%parse-param {dagon_env* env}

%start program

%token ASSIGN ID NEWLINE COMMA CONSTANT INDENT DEDENT STRING

%%

program: statements { env->node = NULL; }
       | opt_newlines

statements: statements newlines statement
          | statement

statement: assignment
         | expression
         | class_definition

class_definition: CONSTANT ':' INDENT method_definitions opt_newlines DEDENT

method_definitions: method_definitions newlines method_definition
                  | method_definition

method_definition: ID ':' block
                 | ID '(' id_list ')' ':' block

block: INDENT statements opt_newlines DEDENT

id_list: id_list COMMA ID
       | ID

assignment: variable ASSIGN expression

variable: ID
        | '@' ID

expression: variable
          | method_call
          | constructor
          | literal

literal: STRING

constructor: CONSTANT '(' argument_list ')'

method_call: variable '.' ID
           | variable '(' argument_list ')'

argument_list: argument_list COMMA expression
             | expression

newlines: newlines NEWLINE
        | NEWLINE

opt_newlines: newlines
            |

%%

void yyerror(yyscan_t scanner, dagon_env* env, char const *msg) {
  fprintf(stderr, "Error: %s line %d\n", msg, yyget_lineno(scanner));
}

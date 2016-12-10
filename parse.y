%{
  #include <stdio.h>
  #include "dagon.h"
  #include "parse.tab.h"
  #include "lex.yy.h"
  #include "node.h"

  void yyerror(yyscan_t scanner, dagon_env* env, char const *msg);
%}

%define parse.error verbose
%define api.pure true

%lex-param {void* scanner}
%parse-param {void* scanner}
%parse-param {dagon_env* env}

%union {
  dagon_node* node;
  int ival;
  char* sval;
}

%start program

%token ASSIGN NEWLINE COMMA INDENT DEDENT
%token<sval> CONSTANT ID STRING

%type<node> program statements assignment class_definition variable method_call constructor literal
%type<node> statement expression method_definitions method_definition block id_list argument_list

%%

program: statements { env->node = $1; }
       | opt_newlines { $$ = NULL; env->node = NULL; }

statements: statements newlines statement { dagon_list_node_append($$, $3); }
          | statement { $$ = dagon_list_node_new(); dagon_list_node_append($$, $1); }

statement: assignment
         | expression
         | class_definition

class_definition: CONSTANT ':' INDENT method_definitions opt_newlines DEDENT { $$ = dagon_class_definition_node_new($1, $4); }

method_definitions: method_definitions newlines method_definition { dagon_list_node_append($$, $3); }
                  | method_definition { $$ = dagon_list_node_new(); dagon_list_node_append($$, $1); }

method_definition: ID ':' block { $$ = dagon_method_definition_node_new($1, dagon_list_node_new(), $3); }
                 | ID '(' id_list ')' ':' block { $$ = dagon_method_definition_node_new($1, $3, $6); }

block: INDENT statements opt_newlines DEDENT { $$ = dagon_block_node_new($2); }

id_list: id_list COMMA ID { dagon_list_node_append($$, dagon_string_node_new($3)); }
       | ID { $$ = dagon_list_node_new(); dagon_list_node_append($$, dagon_string_node_new($1)); }

assignment: variable ASSIGN expression { $$ = dagon_assignment_node_new($1, $3); }

variable: ID { $$ = dagon_variable_node_new($1); }
        | '@' ID { $$ = dagon_instance_variable_node_new($2); }

expression: variable
          | method_call
          | constructor
          | literal

literal: STRING { $$ = dagon_string_node_new($1); }

constructor: CONSTANT '(' argument_list ')' { $$ = dagon_class_new_node($1, $3); }

method_call: variable '.' ID { $$ = dagon_method_call_node($1, $3, dagon_list_node_new()); }
           | ID '(' argument_list ')' { $$ = dagon_self_method_call_node($1, $3); }

argument_list: argument_list COMMA expression { dagon_list_node_append($$, $3); }
             | expression { $$ = dagon_list_node_new($1); }

newlines: newlines NEWLINE
        | NEWLINE

opt_newlines: newlines
            |

%%

void yyerror(yyscan_t scanner, dagon_env* env, char const *msg) {
  fprintf(stderr, "Error: %s line %d\n", msg, yyget_lineno(scanner));
}

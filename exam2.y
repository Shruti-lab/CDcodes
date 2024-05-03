%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern char* yytext;
void yyerror(char*);
int yylex(void);

%}

%token ID NUM 

%%

declaration : type_definition {
  printf("Successfully parsed: %s = %s\n", $1, $3);
}
;

type_definition : BASE_TYPE dimension_list {
  $$ = malloc(sizeof($1) + sizeof(int) * 2); // Allocate memory for type and dimensions
  strcpy($$, $1);
  memcpy($$ + strlen($1), $2, sizeof(int) * 2);
}
;
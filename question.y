%{
#include <stdio.h>
int yylex(void);
void yyerror(char*);
int a,b,c;
%}

%token INT INTEGER IF ELSE ID

%%


program : declares stmts '\n'
        ;

declares : INT var ';'
            ;

var : var ',' ID
    | ID
    ;
    
stmts   : stmts stmt
        | stmt
        ;
stmt    : if_else 
        | assign_stmt
        ;
assign_stmt : ID '=' expr ';'
            {
                if($1=='a'){
                    a=$3;
                }

                else if($1=='b'){
                    b=$3;
                }
                else if($1=='c'){
                    c=$3;
                }
            }
            ;
expr    : INTEGER       {$$=$1;}
        ;

if_else : IF '(' expr ')' stmt ELSE stmt
            {
                if($3==5)
                    b=b+$1;
                else
                    c=+$1;
            }
            ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(){
    yyparse();
    printf("a=%d\n",a);
    printf("b=%d\n",b);
    printf("c=%d\n",c);
    return 0;
}



%{
#include <stdio.h>
int a, b, c;
%}

program:
  declaration_list statement_block
  ;

declaration_list:
  declaration declaration_list
|  declaration
  ;

declaration:
  'int' ID ';'
  ;

statement_block:
  '{' statement_list '}'
  ;

statement_list:
  statement statement_list
|  statement
  ;

statement:
  assignment_expr ';'
|  if_statement
  ;

assignment_expr:
  ID '=' expr
  ;

if_statement:
  'if' '(' condition ')' statement_block %prec IF
  'else' statement_block
  |  'if' '(' condition ')' statement_block
  ;

condition:
  expr relop expr
  ;

relop:
  '==' | '!=' | '<' | '>' | '<=' | '>='
  ;

expr:
  NUMBER
|  ID
|  expr '+' expr
  ;

ID: IDENTIFIER ;

NUMBER: [0-9]+ ;

%%

void assignment_expr(char *id, int val) {
  switch (*id) {
    case 'a': a = val; break;
    case 'b': b = val; break;
    case 'c': c = val; break;
  }
}

int main() {
  yyparse();
  printf("a = %d, b = %d, c = %d\n", a, b, c);
  return 0;
}

%%

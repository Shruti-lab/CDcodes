%{
#include <stdio.h>
int yylex(void);
int tempCount = 0;
int yyerror(char *s);
int newTemp();
int cnt=0;
%}

%token  ID  LT GT AND OR


%%
statement_list: statement_list statement | statement
;

statement: expression '\n' { printf("%s\n", $1); }
;

expression: expression OR term {
    $$ = newTemp();
    printf("t%d = %s OR %s\n", $$, $1, $3);
}
| term
;

term: term AND factor {
    $$ = newTemp();
    printf("t%d = %s AND %s\n", $$, $1, $3);
}
| factor
;

factor: ID LT ID {
    $$ = newTemp();
    printf("t%d = %s < %s\n", $$, $1, $3);
    cnt++;
}
| ID GT ID {
    $$ = newTemp();
    char x=$1;
    printf("t%d = %s > %s\n", $$, x, $3);
    cnt++;
}
| '(' expression ')' { $$ = $2; }
;

%%
int newTemp() {
    return ++tempCount;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}

int main() {
    yyparse();
    printf("E = t%",cnt);
    return 0;
}
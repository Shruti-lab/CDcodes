%{
#include <stdio.h>
int yylex();
void yyerror(const char *);
%}

%token NUMBER

%%
statement   : expr '\n'         { printf("Result: %d\n", $1); }
            ;

expr        : expr '+' expr     { $$ = $1 + $3; }
            | expr '-' expr     { $$ = $1 - $3; }
            | expr '*' expr     { $$ = $1 * $3; }
            | expr '/' expr     { $$ = $1 / $3; }
            | NUMBER            { $$ = $1; }
            ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}
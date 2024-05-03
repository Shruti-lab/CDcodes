%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char*);
%}

%%
if                return IF;
else		  return ELSE;
then		  return THEN;
[a-zA-Z][a-zA-Z0-9]*    return ID;
[0-9]+             {yylval=atoi(yytext); return NUM;}
[ \t]                 ;
\n                yyterminate();
.                 return yytext[0];
%%

void yyerror(char *s)
{ fprintf(stderr, "Invalid input %s\n", s); }


int yywrap(){
    return 1;
}
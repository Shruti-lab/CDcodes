%{
    #include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
int yyerror(char*);
%}

%%
\<      { return LT; }
\>      { return GT; }


or      { return OR; }
and     { return AND; }
[a-zA-Z]+   {  return ID; }
\n      { return '\n'; }
[ \t]   { /* ignore whitespace */ }
.       { yyerror("Invalid character"); }
%%

int yywrap() {
    return 1;
}
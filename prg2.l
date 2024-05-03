/* int a,b,c; a=5; b=2; c=1; if(a==5) b=b+1; else c=c+1;*/
/* general code */

%{
    #include <stdlib.h>
    #include "y.tab.h"
    void yyerror(char *s);
%}

letter[a-z]
digit[0-9]
id {letter}({letter}|{digit})*

%%
[ \t]  {}
"int" {return INT;}
[0-9]+ {yylval.num=atoi(yytext); return INTEGER;}
"if"  { return IF;}
"else"    { return ELSE;}
{id} {yylval.str=strdup(yytext);return ID;}
[-+*/] {yylval.str=strdup(yytext);return OP;}
[()=,;\n] {return *yytext;}
. {yyerror("invalid character");}
%%

int yywrap()
{
    return 0;
}

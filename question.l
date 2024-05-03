/* if then and eval */

%{
    #include "y.tab.h"
    void yyerror(char *s);
%}

letter[a-z]
digit[0-9]
id {letter}({letter}|{digit})*

%%
[ \t]  {}
"int" {return INT;}
[0-9]+ {yylval=atoi(yytext); return INTEGER;}
"if"  { return IF;}
"else"    { return ELSE;}
{id} {yylval = yytext[0];return ID;}
[-+*/()=,;\n] {return *yytext;}
. {yyerror("invalid character");}
%%

int yywrap()
{
    return 0;
}
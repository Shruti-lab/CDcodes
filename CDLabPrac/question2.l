%{
    #include<stdio.h>
    #include<stdlib.h>
    #include "y.tab.h"
    void yyerror(char *s);
%}

%%
int         return INT;
real        return REAL;
[a-zA-Z][a-zA-Z0-9]*        return ID;
[0-9]+          {yylval=atoi(yytext);  return NUM;}
[=]         return EQUAL;
[\t]        ;
[ ]         ;
\n          yyterminate();
.           {return yytext[0];}
%%

void yyerror(char *s){
    printf("Error");
}

int yywrap(){
    return 1;
}

/*lex cannot return-> [,]         {return COMMA;}*/
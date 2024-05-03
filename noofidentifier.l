/*Counting number of identifiers*/
%{
#include<stdio.h>
int cnt=0;
%}

digit [0-9]
letter [a-zA-Z]

%%
{letter}({letter}|{digit})*   cnt++;
%%
int yywrap(){return(1);}
int main(){
    yylex();
    printf("Number of identifiers = %d",cnt);
    return 0;
}
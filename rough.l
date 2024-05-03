%{
#include<stdio.h>
%}

%%
"xy"  {printf("%s",yytext);} /*prints text having "xy" expression in it*/
.     {int num = atoi(yytext);
        if(num==0){
            printf("No digits in text. ");
        }
        else{
            printf("digits in text are: %d",num);
        }}
%%



int yywrap()
{
    return 1;
}

int main(){
    yylex();
    return 0;
}


%{
#include<stdio.h>
int i;
%}

%%
[0-9]+ { int num = atoi(yytext); //convert matched text to an integer
         if(num%2==0)
            printf("%d is EVEN\n",num);
         else
            printf("%d is ODD\n",num);
        }
.        printf("Invalid input\n");
%%
int yywrap(){return(1);}
int main(){
    yylex();
    return 0;
}


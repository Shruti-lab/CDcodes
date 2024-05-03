%{
    #include<stdio.h>
    int keyword_count=0, operators=0;
    int floatnumbers = 0, numbers = 0;
    int identifiers = 0;
%}


digit [0-9]
letter [a-zA-Z]
reserveWords {else|if|printf|while|int|switch|for|char}
floatnumber {digit}+.{digit}+
integers {digit}+

%%
"else|if|printf|while|int|switch|for|char"    {keyword_count++;}
{floatnumber}           {floatnumbers++;}
{letter}[{letter}|{digit}]*     {identifiers++;}
%%
int yywrap(){ return 1;}
int main(){
    yylex();
    printf("\nNumber of identifiers = %d",identifiers);
    printf("\nNumber of keywords = %d",keyword_count);
    printf("\nNumber of integers = %d",floatnumbers);
    return 0;
}
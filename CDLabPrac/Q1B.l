/*lex program to count number of characters, blank spaces, tabs, lines in given text document*/
%{
    #include<stdio.h>
    int spaces=0, chars = 0, lines = 0,words=0;
%}

blankspace [ ]
newline [\n]
%%
{blankspace} spaces++;
{newline} lines++;
.  chars++;                                     
([a-zA-Z0-9])*    {words++;}
%%

int yywrap(){return 1;}
int main(){
    yylex();
    printf("\nNumber of blank spaces: %d",spaces);
    printf("\nNumber of characters: %d",chars);
    printf("\nNumber of lines: %d",lines);
    printf("\nNumber of words: %d",words);

}
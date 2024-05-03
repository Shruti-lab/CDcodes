/*lex program to count number of characters, blank spaces, tabs, lines in given text document*/
%{
    #include<stdio.h>
    int spaces=0, chars = 0, tabs = 0, lines = 0,words=0;
%}

blankspace [ ]
tab [\t]
newline [\n]
%%
{blankspace} spaces++;
{tab}  tabs++;
{newline} lines++;
.  chars++;                                         /*[a-zA-Z0-9%.!@#]*   chars++;*/
([a-zA-Z0-9])*    {words++;}
%%

int yywrap(){return 1;}
int main(int argc, char* argv[]){
    if(argc==2){
        yyin = fopen(argv[1],"r");
    }else{
        printf("Enter the input here: ");
        yyin = stdin;
    }
    yylex();
    printf("\nNumber of blank spaces: %d",spaces);
    printf("\nNumber of characters: %d",chars);
    printf("\nNumber of tabs: %d",tabs);
    printf("\nNumber of lines: %d",lines);
    printf("\nNumber of words: %d",words);

}
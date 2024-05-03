/*lex code to accept data from input file and copy to output file*/

%{
#include<stdio.h>
#include<string.h>
char line[100];
 
%}
%%
['\n']    { fprintf(yyout,"%s\n",line);}
(.*)      { strcpy(line,yytext);}
<<EOF>> { fprintf(yyout,"%s",line); return 0;}
%%
 
 
int yywrap()
{
    return 1;
}
 
/* code section */
int main()
{
        extern FILE *yyin, *yyout;
        /* open the source file 
           in read mode */
    yyin=fopen("comments.txt","r");
 
         
        /* open the output file 
           in write mode */
    yyout=fopen("output.txt","w");
    yylex();
}
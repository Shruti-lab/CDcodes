/*lex program to count number of comment lines*/
%{
#include<stdio.h>
int multiLinecmt=0, singleLinecmt=0;
%}

%%
"/*"[a-zA-Z0-9 .!\t\n]*"*/"  {multiLinecmt++;}
"//"[a-zA-Z0-9 .!\t]*"\n"     singleLinecmt++;
%%
int yywrap(){return(1);}
int main(int argc, char* argv[]){
    if(argc==2){
        yyin = fopen(argv[1],"r");
    }else{
        printf("Enter the input here: ");
        yyin = stdin;
    }
    yylex();
    printf("Number of Single Line comments = %d\n",singleLinecmt);
    printf("Number of Multi Line comments = %d\n",multiLinecmt);
    return 0;
}
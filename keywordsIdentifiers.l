/*Identify following tokens "if,else,scanf,printf,return,goto,while and identifiers"*/

%{
    #include<stdio.h>
    int keyword=0, identifier = 0, numbers=0, operators=0;
%}

digit [0-9]
letter [a-zA-Z]
reserveWords {else|if|printf}
number {digit}+(.{digit}+)?(E[+-]?{digit}+)?
operator [+|-|/|*|**|=|<=|>=|==|+=|-=|*=]

%%
else|if|printf|while|goto|return  {keyword++;}
[{operator}]+       {operators++;}
{number}       numbers++;
{letter}[{letter}|{digit}]*  identifier++;
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
    printf("\nNumber of identifiers = %d",identifier);
    printf("\nNumber of keywords = %d",keyword);
    printf("\nNumber of operators = %d",operators);
    printf("\nNumber of numbers = %d",numbers);
    return 0;
}

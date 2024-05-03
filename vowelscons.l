/*lex code to count number of vowels and consonants in file*/

%{
#include<stdio.h>
int vowels=0, cons=0;
%}

%%
[aeiouAEIOU]  vowels++; printf("Vowel count = %d",vowels);
[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z]    cons++;  printf("Consonant count = %d",cons);
%%
int yywrap(){return(1);}
int main(){
    yylex();
    printf("Vowel count = %d\n",vowels);
    printf("Consonant count = %d\n",cons);
    return 0;
}
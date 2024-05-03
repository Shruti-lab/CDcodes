 
/*lex code to accept a valid integer and float value using lex program.*/
%{
#include<stdio.h>
int validfloat=0, validint=0;
%}

%% 
^[-+]?[0-9]+$               {validint++; printf("It is a valid integer.\n"); }
^[-+]?[0-9]*[.][0-9]+$     {validfloat++; printf("It is a valid floating number.\n");}
.; 
%% 
int yywrap(){return(1);}
int main() 
{ 
  yylex(); 
  if(validint!=0) 
  {
    printf("Number of Valid integers: %d\n",validint); 
  }
  if(validfloat!=0) {
    printf("Number of valid floating points: %d\n",validfloat); 
    }
  if(validint==0 && validfloat==0) printf("Not valid Integer/Float number\n"); 
  return 0; 
} 
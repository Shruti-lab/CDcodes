%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern char* yytext;
%}

%token ID NUM IF ELSE THEN
%left '+' '-'
%left '*' '/'
%right '=' '>'
%left UMINUS

%%


P : P line
  |
  ;

line: assign
    | if_statement
    ;
assign : V '=' {push();} E {codegen_assign();} ';'
       ;
if_statement : IF '(' cond ')' {lab1();} THEN '{' E ';' '}' {lab2();} ELSE '{' E ';' '}' {lab3();} 
  ;
cond:  V '>' { push();} E{codegen_less();}
   ;
E :V '='{push();} E{codegen_assign();}
  | E '+'{push();} E{codegen();}
  | '(' E ')'
  | '-'{push();} E{codegen_umin();} %prec UMINUS
  | V
  | NUM{push();}
  ;
F: '[' {push();} V ']' {push();} {codegen_array();} F
    |
    ;
V : V F
  | ID { push(); }
  ;
%%

char st[100][10];
int top=0;
int label[20];
char i_[2]="0";
char temp[2]="t";

int lnum=0, ltop=0;

int main()
 {
 printf("Enter the expression : ");
 yyparse();
return 0;
}

void push()
 {
  strcpy(st[++top],yytext);
 }

void codegen()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
  printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);
  top-=2;
 strcpy(st[top],temp);
 i_[0]++;
 }

void codegen_array()
{
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = %s %s %s %s\n",temp,st[top-3],st[top-2],st[top-1],st[top]);
 top-=3;
 strcpy(st[top],temp);
 i_[0]++;
}

void codegen_umin()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("%s = -%s\n",temp,st[top]);
 top--;
 strcpy(st[top],temp);
 i_[0]++;
 }

void codegen_assign()
 {
 printf("%s = %s\n",st[top-2],st[top]);
 top-=2;
 }

void codegen_less()
 {
 strcpy(temp,"t");
 strcat(temp,i_);

 printf("%s = %s > %s\n",temp, st[top-2],st[top]);
 top-=2;
 strcpy(st[++top], temp);
 i_[0]++;
 }

void lab1()
{
 lnum++;
 strcpy(temp, "t");
 strcat(temp, i_);
 printf("%s = not %s\n", temp, st[top]);
 printf("if %s goto L%d\n", temp, lnum);
 i_[0]++;
 label[++ltop] = lnum;
}

void lab2()
{
int x;
lnum++;
x=label[ltop--];
printf("goto L%d\n",lnum);
printf("L%d: \n",x);
label[++ltop]=lnum;
}

void lab3()
{
int y;
y=label[ltop--];
printf("L%d: \n",y);
}


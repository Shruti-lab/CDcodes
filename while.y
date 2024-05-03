%{
#include<stdio.h>
void yyerror(char *s);
int yylex(void);
%}
%token FOR ID BOP UOP NUMBER DO WHILE IF ELSE
%%
prg: FOR '(' lexp ';' lexp ';' lexp ')' lbody 	{printf("For loop");}
| WHILE '(' lexp ')' lbody			{printf("While loop executed successfully!");}
| DO codeblock WHILE '(' lexp ')' ';'		{printf("DO while");}
| IF '(' lexp ')' lbody				{printf("IF... executed successfully!");}
| IF '(' lexp ')' lbody	ELSE lbody		{printf("IF..ELSE executed successfully!");}
;
lbody: stmt
| codeblock
;
codeblock:'{' stmt_list '}'
;
stmt_list: stmt_list stmt
|
;
stmt: lexp ';'
;
lexp: fexp			/*loop exp does not ends with semi*/
|				/*loop segments can be blank*/
;
fexp: fexp ',' exp		/*comma separated exp*/
|exp
|'(' fexp ')'			/*use braces for prio*/
;
exp: ID BOP exp			/*binary operator in the middle*/
| ID UOP			/*Unary operator at right*/
| UOP ID
| ID
| NUMBER
;
%%
int main()
{
yyparse();
return 0;
}

void yyerror(char *s)
{
printf("error");
}
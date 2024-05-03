%{
#include <stdio.h>
#include<string.h>
#include<stdbool.h>
#include<stdint.h>
#include<stdlib.h>
int yylex(void);
void yyerror(char*);

typedef struct variables{
    char *var;
    int val;
}vars;

vars arr[20];
int varCount=0;
bool executed=false;


void assign_id(char *name,int value){
         printf("id is %s and value is %d\n",name,value);
                   // printf("hii1\n");
                    // Store the address of the integer in the char pointer

               arr[varCount].var=strdup(name);
               if (arr[varCount].var == NULL) {
                   fprintf(stderr, "Error: Failed to allocate memory.\n");
                   exit(EXIT_FAILURE);
               }
               //printf("hii2\n");
               arr[varCount].val=value;
               printf("in structure id is %c, value is %d\n",*(arr[varCount].var),arr[varCount].val);
               varCount++;
}

%}

%union {
    char* str;
    int num;
}

%token INT INTEGER IF ELSE ID OP
%type <str> ID OP
%type <num> VALUE
%type <str> program declares varid stmts
%type <num> stmt assign_stmt if_else expr stmt_eval

%%


program : declares stmts  {printf("completed\n"); }
        ;

declares : INT varid ';' '\n'    
            ;

varid : varid ',' ID                {printf("variable value=%s\n",$$);}
    | ID
    ;
    
stmts   : stmts stmt        {printf("stmts value=%s\n",$$);}
        | stmt 
        ;
stmt    : assign_stmt 
        |  if_else   {printf("program value=%d\n",$1);}     
        
assign_stmt : ID '=' VALUE ';' '\n'
            {
               //yylval.id=$1; 
               //yylval.value=$3;
               assign_id($1,$3);
              
            }
            ;

if_else : IF '(' expr ')' '\n'{if($3==1){executed=true;}} stmt_eval ELSE '\n'{ executed=!executed;} stmt_eval 
            {                               printf("reaches if_else expr value=%d\n",$3);

            }
            ;

expr    :   ID '=' '=' VALUE
            {
                $$=0;
                for(int i=0;i<varCount;i++){
                     printf("id is %s struc variable and value is %s , %d, i value is %d\n",$1,(arr[i].var),arr[i].val,i);
                    if(*(arr[i].var)==*($1) && arr[i].val==$4){
                        $$=1;
                        break;
                    }
                }
            }
        ;


stmt_eval : ID '=' ID OP VALUE ';' '\n'
                { if(executed){
                    for(int i=0;i<varCount;i++){
                        if(*($1)==*(arr[i].var))
                        {
                            if(*($4)=='+')
                                arr[i].val+=$5;
                            else if(*($4)=='-')
                                arr[i].val-=$5;
                            else if(*($4)=='*')
                                arr[i].val*=$5;
                            else if(*($4)=='/')
                                arr[i].val/=$5;
                            $$=arr[i].val;
                            break;
                        }
                    }
                     printf("modifying id and value are %s,%d\n",$1,$$);
                  }
                }
            ;

VALUE   : INTEGER
        ;          

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(){
    yyparse();
   for(int i=0;i<varCount;i++){
    printf("%c->%d\n",*(arr[i].var),arr[i].val);
   }
    return 0;
}

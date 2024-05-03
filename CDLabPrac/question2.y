%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    extern char* yytext;
    void yyerror(char*);
    int yylex(void);
    void assign1(char c);
    void assign2(char c);
    void numassign1(int c);
    void numassign2(int c);
    int t=0;
    int oneD = 0;
    
    struct variables{
        char var1;
        char var2;
        int num1;
        int num2;
    }v;
%}



%token EQUAL, INT, REAL, INTEGER, ID, NUM

%start declaration

%%
declaration : result EQUAL Dexp   {printf("\nTop level parsed...");  printf("%s",$1);}
            |   Dexp                {printf("\n--------ids------");}
            ;

result : ID
        ;

Dexp :Texp  Lexp                {printf("\n D->TL parsed......");}
    ;            
Texp : INT                      { printf("\nArray of type int....."); t=0;}
     | REAL                     { printf("\nArray of type real....."); t=1;}
     ;

Lexp: Lone ',' Iexp           { printf("\nParsed comma part......"); }
    | Iexp                      { printf("\n");  oneD=1;}
    ;


Lone : '[' NUM ']'              { printf("\n 2D array parsed!!!!"); numassign1($2); }
    | Lexp
    ;  

Iexp: '[' NUM ']'                   {printf("\n 1D array parsed!!!!");  numassign2($2);}
    | ID                            {printf("\nPrinting id..");}
    ;

%%

int main(){
    printf("Enter the expression:- ");
    yyparse();
    if(t==0 && oneD==0){
        printf("\nW = int [%d],[%d]",v.num1,v.num2);
    }else if(t==1 && oneD){
        printf("\nW = real [%d],[%d]",v.num1,v.num2);
    }else if(t==0 && oneD==1){
        printf("\nW = int [%d]",v.num2);
    }else{
        printf("\nW = int [%d]",v.num2);
    }
    return 0;
}

void assign1(char c){
    v.var1 =  c;
}
void assign2(char c){
    v.var2 =  c;
}
void numassign1(int c){
    v.num1 =  c;
}
void numassign2(int c){
    v.num2 = c;
}
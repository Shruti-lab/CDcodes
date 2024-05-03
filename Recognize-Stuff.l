%{
    #include <stdio.h>
    int ifCount = 0;
    int thenCount = 0;
    int elseCount = 0;
    int whileCount = 0;
    int doCount = 0;
    int forCount = 0;
    int returnCount = 0;
    int gotoCount = 0;
    int identifierCount = 0;
%}

DIGIT [0-9]
LETTER [a-z]
ID {LETTER}({LETTER}|{DIGIT})*

%%
if       { ifCount++; }
then     { thenCount++; }
else     { elseCount++; }
while    { whileCount++; }
do       { doCount++; }
for      { forCount++; }
return   { returnCount++; }
goto     { gotoCount++; }
{ID}       { identifierCount++; }
.        {}
%%

printf("if count: %d\n", ifCount);

int main() {
    yylex();
    printf("if count: %d\n", ifCount);
    printf("then count: %d\n", thenCount);
    printf("else count: %d\n", elseCount);
    printf("while count: %d\n", whileCount);
    printf("do count: %d\n", doCount);
    printf("for count: %d\n", forCount);
    printf("return count: %d\n", returnCount);
    printf("goto count: %d\n", gotoCount);
    printf("Identifier count: %d\n", identifierCount);
    return 0;
}

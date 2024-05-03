%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Symbol {
	char lexeme[50];
	char type[20];
	int value;
};

struct SymbolTable {
	struct Symbol entries[1000];
	int num_entries;
};

struct SymbolTable symbol_table;

void addSymbol(char* name, char* type, int value)
{
	if(symbol_table.num_entries <1000)
	{
		int i =0;
		for(i=0; i<symbol_table.num_entries; i++)
		{
			if(strcmp(symbol_table.entries[i].lexeme, name) == 0)
				break;
		}
		if(i==symbol_table.num_entries)
		{
		    strcpy(symbol_table.entries[symbol_table.num_entries].lexeme, name);
		strcpy(symbol_table.entries[symbol_table.num_entries].type, type);
	    	symbol_table.entries[symbol_table.num_entries].value = value;
		symbol_table.num_entries++;
		}
	}
}

int numChar=0;
int numWord=0;
int numBlank=0;

%}

%%

int|float|main|void|printf|return	{ addSymbol(yytext, "Reserved", -1.0); 
					numWord++;
					numChar += yyleng;}

"("|")"|"{"|"}"|"="|","|"+"|";"|"\""	{ addSymbol(yytext, "Delimiter", -1.0); 
					numChar += yyleng;}

"%d"				{ addSymbol(yytext,"FSpecifier", -1.0); 
					numChar += yyleng;}

[0-9]+			{ addSymbol(yytext, "Constant", atoi(yytext)); 
				numChar += yyleng;}

[a-zA-Z][a-zA-Z0-9]*	{ addSymbol(yytext, "Identifier", -1.0);
			numWord++;
			numChar += yyleng; }
[ \t\n]			{ numChar += yyleng;
			numBlank += yyleng; }
.				;

%%

int main(void) {
  yylex();
  printf("Symbol Table\n------------------------------\n");
  printf("Lexeme\tType\t\tValue\n");
  for (int i = 0; i < symbol_table.num_entries; i++) {
    printf("%s\t%s\t", symbol_table.entries[i].lexeme, symbol_table.entries[i].type);
	if(symbol_table.entries[i].value != -1.0)
	    printf("%d\n", symbol_table.entries[i].value);
	else
	    printf("-\n");
  }
  
  printf("\nNo. of characters = %d", numChar);
  printf("\nNo. of words = %d", numWord);
  printf("\nNo. of blank characters = %d\n", numBlank);
  return 0;
}


int yywrap(){
	return 1;
}
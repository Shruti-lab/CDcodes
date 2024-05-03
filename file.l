%{
    #include <stdlib.h>
    void yyerror(char *);
    #include "y.tab.h"
%}

%%
[0-9]+                 {
                          yylval = atoi

                       }
%%
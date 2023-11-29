%{

%}


%%
"\w"(.)*"\w"       {printf("%s", yytext);}
"//"(.)*           {}
"/*"[^}]*"*/"      {}
"/*"                {printf("syntax error\n"); return 0;}
"*/"                {printf("syntax error\n"); return 0;}

%%

yywrap(){}

int main(){

yyin = fopen("prorgra.txt","r");

yylex();
return 0;

}

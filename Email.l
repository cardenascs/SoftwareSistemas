cuerpo [a-zA-Z0-9]
terminacion [hotmail.com|gmail.com|uas.edu.mx|xyz("."*|""|a-z).mx]

%{
%}


%%
{cuerpo}+("-"|""|"_"|"")+@{terminacion} {printf("Valido");}
.	{printf("Invalido\n");}
%%

yywrap(){}
int main(){
yylex();

return 0;
}

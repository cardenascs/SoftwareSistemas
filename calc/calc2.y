%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
 #include<string.h>
 void yyerror(char *);
 int yylex(void);
 int vet[20];
 extern FILE* yyin;
%}

%token NUMBER VARIAVEL
%token UMENOS ABREP FECHAP MAIS MENOS VEZES DIV IGUAL ENTER POT BTS MOD VABS SQRT BTSR
%left MAIS MENOS IGUAL 
%left POW DIV VEZES 
%%
program:
 program statement ENTER
 | /* NULL */
 ;
statement:
 expression  { printf("%d\n", $1); }
 | VARIAVEL IGUAL expression { vet[$1] = $3; }
 ;
expression:
 NUMBER
 | VARIAVEL { $$ = vet[$1]; }
 | MENOS expression { $$ = -$2; }
 | expression MAIS expression { $$ = $1 + $3; }
 | expression MENOS expression { $$ = $1 - $3; }
 | expression VEZES expression { $$ = $1 * $3; }
 | expression DIV expression { $$ = $1 / $3; }
 | ABREP expression FECHAP { $$ = $2; }
 | SQRT expression %prec UMENOS { $$ = sqrt($2); }
 | expression BTS expression { $$ = $1 << $3; }
 | expression MOD expression { $$ = $1 % $3; }
 | VABS expression %prec UMENOS { $$ = abs($2); }
 | expression POT expression { $$ = pow($1, $3); }
 | expression BTSR expression { $$ = $1 >> $3; }
 ;
%%
void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
}

void readFile(FILE *file){
 char cad;
 while ((cad = fgetc(file)) != EOF){
  printf("%c", cad);
 }
 rewind(file);
}

int main(int argc, char *argv[]){
 char cad;
 if(argc != 2){
  fprintf(stderr, "Pon un archivo plis %s \n", argv[0]);
  return 1;
 }

 FILE *file = fopen(argv[1], "r");
 if (!file){
  perror("Error while open file!");
  return 1;
 }

 readFile(file);
 
 yyin = file;	
 yyparse();
 fclose(file);

 return 0;
}
 

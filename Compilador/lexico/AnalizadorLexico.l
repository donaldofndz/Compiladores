%{
/* Este programa es una analizador léxico para la meteria de Compiladores, sigue las clases de los archivos adjuntos
	al codigo fuente del programa 
*/
FILE *archSal;
%}
dig     [0-9]
let     [a-z]
entero  {dig}+
oparit  "+"|"-"|"*"|"/"|"%"{1,1}
opespe  "%"|"&"|"^"|"|"|"<<"|">>"{1,1}
opasig  (oparit)"="|(opespe)"="|"="{1,2}
palres  DOBLE|ENTERO|HAZ|MIENTRAS|PARA|REAL|SI|SINO
identi  let+(let|dig)*

%%
{oparit}  printf("Lei un operador: %s \n",yytext);
{opespe}  printf("Lei un operador especial: %s \n",yytext);
{opasig}  printf("Lei un operador asignacion: %s \n",yytext);
{palres}  printf("Aqui hay un palabra reservada: %s\n",yytext);
{identi}  printf("Aqui hay un identificador: %s\n",yytext);
.         ;
%%
main(int argc, char *argv[])
   {
     yyin = fopen(argv[1],"r");
     archSal = fopen("salida.txt","w");
     yylex();
     fclose(archSal);
}
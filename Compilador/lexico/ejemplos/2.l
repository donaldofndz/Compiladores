%{
/* Programa que lee un programa y hace el
   reconocimiento de identificadores,
   palabras reservadas y enteros de un
   lenguaje x
*/
FILE *archSal;
%}
dig     [0-9]
let     [a-z]
entero  {dig}+
ident   {let}({let}|{dig})*
palres  if|else|while|int|char
%%
{entero}  fprintf(archSal," %s es un entero\n", yytext);
{palres}  fprintf(archSal," %s es un identificador\n", yytext);
{ident}   fprintf(archSal," %s es un identificador\n", yytext);
%%
main(int argc, char *argv[])
   {
     yyin = fopen(argv[1],"r");
     archSal = fopen("salida.txt","w");
     yylex();
     fclose(archSal);
}

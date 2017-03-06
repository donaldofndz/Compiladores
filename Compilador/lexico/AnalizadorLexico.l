%{
/* Este programa es una analizador léxico para la meteria de Compiladores, sigue las clases de los archivos adjuntos
	al codigo fuente del programa 
*/
#include <string.h>
FILE *archSal;
void tamanioIdenti(char* cadena);
const char *opAsignacion[] = {"=","+=","-=","*=","/=","%=","&=","^=","|=",">>=","<<="};
const char *opRelacion[] = {">",">=","<","<=","==","!="};
const char *palReservada[] = {"DOBLE","ENTERO","HAZ","MIENTRAS","PARA","REAL","SI","SINO"};
int contidenti;
%}
dig     [0-9]
let     [a-z]
entero  {dig}+
oparit  "+"|"-"|"*"|"/"|"%"{1,1}
opespe  "%"|"&"|"^"|\||"<<"|">>"
opasig  ({oparit})"="|({opespe})"="|"="
oprela  ">"|"<"|">="|"<="|"=="|"!="
simesp  ";"|","|"("|")"|"["|"]"
palres  DOBLE|ENTERO|HAZ|MIENTRAS|PARA|REAL|SI|SINO
identi  {let}+({dig}|{let})*
decima  [1-9]{dig}+
octals  0[1-7]+
hexade  0(x|X)({dig}|[a-f]|[A-F])+
reales  0|{dig}+\.{dig}*
cadena  \"(\\.|[^\\"])*\"
saltos  [ \n\t\r\f]+
coment  \@.*
%%
{opasig}  {int i;
	       printf("0 ");
           for(i=0;i<=10;i++){
			   if(strcmp(yytext,opAsignacion[i])== 0){
			   printf("%d\n",i);
		       }
             }
	       }
{oprela}  {int i;
	       printf("1 ");
           for(i=0;i<=6;i++){
			   if(strcmp(yytext,opRelacion[i])== 0){
			   printf("%d\n",i);
		       }
             }
	       }
{identi}  {printf("2 ");
           printf("\n");}
{palres}  {int i;
	       printf("3 ");
           for(i=0;i<=8;i++){
			   if(strcmp(yytext,palReservada[i])== 0){
			   printf("%d\n",i);
		       }
             }
	       }
{simesp}  {printf("4 %s\n",yytext);}
{cadena}  {printf("5 ");printf("\n");}
{oparit}  {printf("6 %s\n",yytext);}
{decima}  {printf("7 %s\n",yytext);}
{octals}  {printf("7 %s\n",yytext);}
{hexade}  {printf("7 %s\n",yytext);}
{reales}  {printf("8 %s\n",yytext);}
{coment}  ;
{saltos}  ;
.         {printf("Aqui hay un error %s --, podras continuar cuando lo corrijas\n",yytext);};
%%

void tamanioIdenti(char* cadena){
	
	int aux;
	aux = strlen(cadena);
	printf("%d ",aux);
	if(aux <=8){
		printf("%s \n",cadena);
		}else{
			printf("No puedo reconocer esto\n");
		}
	
}


int main(int argc, char *argv[])
   {
     yyin = fopen(argv[1],"r");
     archSal = fopen("salida.txt","w");
     yylex();
     fclose(archSal);
}
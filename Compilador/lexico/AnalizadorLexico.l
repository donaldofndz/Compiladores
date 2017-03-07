%{
/* 
	ALUMNO: JOSE DONALDO FERNANDEZ MONTENEGRO
	Este programa es una analizador léxico para la meteria de Compiladores, se le pasa en ejecucion un codigo y devuelve los siguientes:
	- Archivo con Tokens
	- Archivo con Errores
	- Archivo con Cadenas
	- Archivo con identificadores
*/
#include <string.h>
FILE *archSal, *archErr, *archTI,*archTC;

struct tablaSimbolos{
	int posicion;
	char nombre[20];
	int tipo;
};

struct tablaCadenas{
	int posicion;
	char *str;
};

int contidenti = 0,contcadena = 0;
struct tablaSimbolos tsimbolos[100];
struct tablaCadenas tcadenas[100];
void imprime();
void tamanioIdenti(char* cadena);
int identificador(char* cadena);
int cadenaalm(char* cadena);
const char *opAsignacion[] = {"=","+=","-=","*=","/=","%=","&=","^=","|=",">>=","<<="};
const char *opRelacion[] = {">",">=","<","<=","==","!="};
const char *palReservada[] = {"DOBLE","ENTERO","HAZ","MIENTRAS","PARA","REAL","SI","SINO"};

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
	       fprintf(archSal,"0 ");
           for(i=0;i<=10;i++){
			   if(strcmp(yytext,opAsignacion[i])== 0){
			   fprintf(archSal,"%d\n",i);
		       }
             }
	       }
{oprela}  {int i;
	       fprintf(archSal,"1 ");
           for(i=0;i<=6;i++){
			   if(strcmp(yytext,opRelacion[i])== 0){
			   fprintf(archSal,"%d\n",i);
		       }
             }
	       }
{identi}  {fprintf(archSal,"2 ");
		   fprintf(archSal,"%d\n",identificador(yytext));
	       contidenti++;
	       }
{palres}  {int i;
	       fprintf(archSal,"3 ");
           for(i=0;i<=8;i++){
			   if(strcmp(yytext,palReservada[i])== 0){
			   fprintf(archSal,"%d\n",i);
		       }
             }
	       }
{simesp}  {fprintf(archSal,"4 %s\n",yytext);}
{cadena}  {fprintf(archSal,"5 ");
           fprintf(archSal,"%d\n",cadenaalm(yytext));
	       contcadena++;}
{oparit}  {fprintf(archSal,"6 %s\n",yytext);}
{decima}  {fprintf(archSal,"7 %s\n",yytext);}
{octals}  {fprintf(archSal,"7 %s\n",yytext);}
{hexade}  {fprintf(archSal,"7 %s\n",yytext);}
{reales}  {fprintf(archSal,"8 %s\n",yytext);}
{coment}  ;
{saltos}  ;
.         {fprintf(archErr,"Aqui hay un error %s -- Podras continuar cuando lo corrijas\n",yytext);};
%%

void tamanioIdenti(char* cadena){
	
	int aux;
	aux = strlen(cadena);
	if(aux > 8){
		fprintf(archErr,"Aqui hay un error %s -- Podras continuar cuando lo corrijas\n",cadena);
		exit(-1);
		}
	
}

int identificador(char* cadena){
	
	int i = 0,bandera,indicador;
	
	tamanioIdenti(cadena); //Limita es tamaño de la cadena
	
	
	if((contidenti+1)==1){
		tsimbolos[contidenti].posicion = contidenti;
		strcpy(tsimbolos[contidenti].nombre,cadena);
		tsimbolos[contidenti].tipo = 0;
		}else{
			for(i = 0; i < (contidenti+1); i++){
				if(strcmp(cadena,tsimbolos[i].nombre) == 0){
					bandera = 1;
					indicador = i;
				}
			}
			if (bandera != 1){
				tsimbolos[contidenti].posicion = contidenti;
				strcpy(tsimbolos[contidenti].nombre,cadena);
				tsimbolos[contidenti].tipo = 0;
				}else{
					bandera = 0;
					contidenti--;
					return(indicador);
					
				}
		}
	
	
	return(contidenti);
	
	
}

int cadenaalm(char* cadena){
	
	int tamano;
	tamano = strlen(cadena);
	tcadenas[contcadena].str = (char *) malloc(tamano);
	tcadenas[contcadena].posicion = contcadena;
	strcpy(tcadenas[contcadena].str,cadena);
	return(contcadena);
}


void imprime(){
	int i;
	for(i = 0; i < (contidenti); i++){
			fprintf(archTI,"%d %s %d \n",tsimbolos[i].posicion, tsimbolos[i].nombre, tsimbolos[i].tipo);
		}
		for(i = 0; i < (contcadena); i++){
				fprintf(archTC,"%d %s\n",tcadenas[i].posicion,tcadenas[i].str);
			}
	}


int main(int argc, char *argv[])
   {
     yyin = fopen(argv[1],"r");
     archSal = fopen("salida.txt","w");
	 archErr = fopen("errores.txt","w");
	 archTI = fopen("TablaSimbolos.txt","w");
	 archTC = fopen("TablaCadenas.txt","w");
     yylex();
     fclose(archSal);
	 imprime();
}
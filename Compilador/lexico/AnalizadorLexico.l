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
FILE *archSal, *archErr, *archTI,*archTC; //Se crean los apuntadores que escribiran en archivo

struct tablaSimbolos{ //Estructura donde se guardará la tabal de simbolos asi como sus atributos 
	int posicion;
	char nombre[20];
	int tipo;
};

struct tablaCadenas{ //Estructura que guarda la tabla de cadenas con sus repectivos atributo
	int posicion;
	char *str; //Cadena que almacena las cadenas de tamaño dinamico
};

int contidenti = 0,contcadena = 0; //Variables que contabilisan las cadenas
struct tablaSimbolos tsimbolos[500]; //variable que almacena los simbolos, esta tabla puede almacenar la cantidad de elementos que se deseen guardar
struct tablaCadenas tcadenas[500]; //variable que almacena las cadenas, esta tabla puede almacenar la cantidad de elementos que se deseen guardar
void imprime(); //Declaracion de funciones usadas posteriormente
void tamanioIdenti(char* cadena);//Declaracion de funciones usadas posteriormente
int identificador(char* cadena);//Declaracion de funciones usadas posteriormente
int cadenaalm(char* cadena);//Declaracion de funciones usadas posteriormente
char cadAtomos[500];
int avanzeAtomos = 0;
const char *opAsignacion[] = {"=","+=","-=","*=","/=","%=","&=","^=","|=",">>=","<<="}; //Cadenas que almacenan los valores a comprar de las tablas
const char opAsigToken[] = {'=','m','n','p','d','s','&','^','|','y','z'};
const char *opRelacion[] = {">",">=","<","<=","==","!="};//Cadenas que almacenan los valores a comprar de las tablas
const char opRelToken[] = {'>','g','<','l','q','!'};
const char *palReservada[] = {"DOBLE","ENTERO","HAZ","MIENTRAS","PARA","REAL","SI","SINO"};//Cadenas que almacenan los valores a comprar de las tablas
const char palResToken[] = {'o','t','h','w','f','x','i','j'};
%}
dig     [0-9]
let     [a-z]
entero  {dig}+
oparit  "+"|"-"|"*"|"/"|"%"{1,1}
opespe  "%"|"&"|"^"|\||"<<"|">>"
opasig  ({oparit})"="|({opespe})"="|"="
oprela  ">"|"<"|">="|"<="|"=="|"!="
simesp  ":"|";"|","|"("|")"|"["|"]"
palres  DOBLE|ENTERO|HAZ|MIENTRAS|PARA|REAL|SI|SINO
identi  {let}+({dig}|{let})*
decima  [1-9]{dig}*|0
octals  0[1-7]+
hexade  0(x|X)({dig}|[a-f]|[A-F])+
reales  {dig}+\.{dig}*
cadena  \"(\\.|[^\\"])*\"
saltos  [ \n\t\r\f]+
coment  \@.*
%%
{opasig}  {int i;
	       fprintf(archSal,"0 ");
           for(i=0;i<=10;i++){
			   if(strcmp(yytext,opAsignacion[i])== 0){
			   fprintf(archSal,"%d\n",i);
			   cadAtomos[avanzeAtomos]=opAsigToken[i];
		       }
             }
			 avanzeAtomos++;
	       }
{oprela}  {int i;
	       fprintf(archSal,"1 ");
           for(i=0;i<=6;i++){
			   if(strcmp(yytext,opRelacion[i])== 0){
			   fprintf(archSal,"%d\n",i);
			   cadAtomos[avanzeAtomos]=opRelToken[i];
		       }
             }
			 avanzeAtomos++;
	       }
{identi}  {fprintf(archSal,"2 ");
		   fprintf(archSal,"%d\n",identificador(yytext));
	       contidenti++;
		   cadAtomos[avanzeAtomos] = 'a';
		   avanzeAtomos++;
	       }
{palres}  {int i;
	       fprintf(archSal,"3 ");
           for(i=0;i<=8;i++){
			   if(strcmp(yytext,palReservada[i])== 0){
			   fprintf(archSal,"%d\n",i);
			   cadAtomos[avanzeAtomos]=palResToken[i];
			   }
             }
			 avanzeAtomos++;
	       }
{simesp}  {fprintf(archSal,"4 %s\n",yytext);
			cadAtomos[avanzeAtomos] = yytext[0];
			avanzeAtomos++;
		   }
{cadena}  {fprintf(archSal,"5 ");
           fprintf(archSal,"%d\n",cadenaalm(yytext));
	       contcadena++;
		   cadAtomos[avanzeAtomos] = '"';
		   avanzeAtomos++;
	   	   }
{oparit}  {fprintf(archSal,"6 %s\n",yytext);
			cadAtomos[avanzeAtomos] = yytext[0];
			avanzeAtomos++;
		  }
{decima}  {fprintf(archSal,"7 %s\n",yytext);
			cadAtomos[avanzeAtomos] = 'e';
			avanzeAtomos++;
			}
{octals}  {fprintf(archSal,"7 %s\n",yytext);
			cadAtomos[avanzeAtomos] = 'e';
			avanzeAtomos++;
		   }
{hexade}  {fprintf(archSal,"7 %s\n",yytext);
			cadAtomos[avanzeAtomos] = 'e';
			avanzeAtomos++;
			}
{reales}  {fprintf(archSal,"8 %s\n",yytext);
			cadAtomos[avanzeAtomos] = 'r';
			avanzeAtomos++;
			}
{coment}  ;
{saltos}  ;
.         {fprintf(archErr,"Aqui hay un error %s -- Podras continuar cuando lo corrijas\n",yytext);};
%%

/*
	De la sección anterior no se comenta linea por linea debido a que Flex puede llegara tener problemas si se comenta linea a linea, cada linea define la acción 
	que realizara cada componenete lexico.
	
*/




void tamanioIdenti(char* cadena){ //funcion que identifica el tamaño de la cadena en caso de que el tamaño sea mayor que 8 generara un error 
	
	int aux; //variable auxiliar para operar
	aux = strlen(cadena); //se comprueba el tamaño de la cadena
	if(aux > 8){ //valua tamaño
		fprintf(archErr,"Aqui hay un error %s -- Podras continuar cuando lo corrijas\n",cadena); //imprime en archivo que hay un archivo
		}
	
}

int identificador(char* cadena){ //funcion que identifica cada identificador para almacenar en la tabla de identificadores evita repeticiones de los mismo
	
	int i = 0,bandera,indicador; //variables necesarias en la funcion
	
	tamanioIdenti(cadena); //Limita es tamaño de la cadena
	
	
	if((contidenti+1)==1){ //para el primer elemento se utiliza la este segmento de codigo
		tsimbolos[contidenti].posicion = contidenti; //se crea almacena valor en la tabla de simbolos
		strcpy(tsimbolos[contidenti].nombre,cadena); //se copia valor a la estructura que almacenara en la tabla de simbolos 
		tsimbolos[contidenti].tipo = 0; //se pasa valor de 0 al tipo, debido a que no se sabe utilziacion
		}else{
			for(i = 0; i < (contidenti+1); i++){ //recorre cada estructura para determinar si el identificador ya existe 
				if(strcmp(cadena,tsimbolos[i].nombre) == 0){
					bandera = 1;
					indicador = i;
				}
			}
			if (bandera != 1){
				tsimbolos[contidenti].posicion = contidenti; //agrega a estructura
				strcpy(tsimbolos[contidenti].nombre,cadena); //agrega a estructura
				tsimbolos[contidenti].tipo = 0; //agrega a estructura
				}else{
					bandera = 0; //condiciones necesarias parael funfcionamiento del algoritmo
					contidenti--;
					return(indicador);
					
				}
		}
	
	
	return(contidenti); //regresa el valor del token 
	//La complejidad algoritmica con Notacion de la big O de este algoritmo es O(n)
	
}

int cadenaalm(char* cadena){ //funcion que agrega cadenas a la tabla de candeas
	
	int tamano; //variable para funcionamiento de algoritos
	tamano = strlen(cadena); //usa tamano de cadena
	tcadenas[contcadena].str = (char *) malloc(tamano); //Hace el tamaño de cadena dinamico
	tcadenas[contcadena].posicion = contcadena; //ingresa la posicion de la cadena
	strcpy(tcadenas[contcadena].str,cadena); //copia valor de la cadena a estructura
	return(contcadena); //regresa token de la cadeana
}


void imprime(){ //imprime la tabla de simbolos y la tabla de cadenas en archivo 
	int i;
	for(i = 0; i < (contidenti); i++){
			fprintf(archTI,"%d %s %d \n",tsimbolos[i].posicion, tsimbolos[i].nombre, tsimbolos[i].tipo);
		}
		for(i = 0; i < (contcadena); i++){
				fprintf(archTC,"%d %s\n",tcadenas[i].posicion,tcadenas[i].str);
			}
	} //El algoritmos a pesar de tener dos fors sigue siendo de complejidad O(n)
	
void mostrarCadAtomos(){
	int i = 0;
	for(i=0;i<500;i++){
		printf("%c",cadAtomos[i]);
	}
	printf("\n");
}


int main(int argc, char *argv[]) //funcion Main
   {
     yyin = fopen(argv[1],"r"); //escritura en archivo
     archSal = fopen("salida.txt","w");//escritura en archivo
	 archErr = fopen("errores.txt","w");//escritura en archivo
	 archTI = fopen("TablaSimbolos.txt","w");//escritura en archivo
	 archTC = fopen("TablaCadenas.txt","w");//escritura en archivo
     yylex(); //usa funcion yylex
     fclose(archSal); //cierra el archivo
	 imprime(); //imprime en archivos
	 mostrarCadAtomos();
}
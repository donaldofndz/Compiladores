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
FILE *archSal, *archErr, *archTI,*archTC,*archTRA; //Se crean los apuntadores que escribiran en archivo

struct tablaSimbolos{ //Estructura donde se guardará la tabal de simbolos asi como sus atributos 
	int posicion;
	char nombre[20];
	int tipo;
};

struct tablaCadenas{ //Estructura que guarda la tabla de cadenas con sus repectivos atributo
	int posicion;
	char *str; //Cadena que almacena las cadenas de tamaño dinamico
};

void p11();
void fun11();
void lf11();
void arg11();
void tipo11();
void la11();
void bs11();
void ls11();
void s11();
void dec11();
void asig11();
void m11();
void h11();
void para11();
void si11();
void li11();
void opAsig11();
void er11();
void erc11();
void opr11();
void e11();
void t11();
void ep11();
void tp11();
void f11();
void anSint();
void obtenerTipo();
void tipos();
void traductor();

int contidenti = 0,contcadena = 0; //Variables que contabilisan las cadenas
struct tablaSimbolos tsimbolos[500]; //variable que almacena los simbolos, esta tabla puede almacenar la cantidad de elementos que se deseen guardar
struct tablaCadenas tcadenas[500]; //variable que almacena las cadenas, esta tabla puede almacenar la cantidad de elementos que se deseen guardar
void imprime(); //Declaracion de funciones usadas posteriormente
void tamanioIdenti(char* cadena);//Declaracion de funciones usadas posteriormente
int identificador(char* cadena);//Declaracion de funciones usadas posteriormente
int cadenaalm(char* cadena);//Declaracion de funciones usadas posteriormente
int contadorTipo;
char cadAtomos[500];
int cadTipos[200];
int contadorCadena = 0;
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
			   cadAtomos[contadorCadena]=opAsigToken[i];
		       }
             }
			 contadorCadena++;
	       }
{oprela}  {int i;
	       fprintf(archSal,"1 ");
           for(i=0;i<=6;i++){
			   if(strcmp(yytext,opRelacion[i])== 0){
			   fprintf(archSal,"%d\n",i);
			   cadAtomos[contadorCadena]=opRelToken[i];
		       }
             }
			 contadorCadena++;
	       }
{identi}  {fprintf(archSal,"2 ");
		   fprintf(archSal,"%d\n",identificador(yytext));
	       contidenti++;
		   cadAtomos[contadorCadena] = 'a';
		   contadorCadena++;
	       }
{palres}  {int i;
	       fprintf(archSal,"3 ");
           for(i=0;i<=8;i++){
			   if(strcmp(yytext,palReservada[i])== 0){
			   fprintf(archSal,"%d\n",i);
			   cadAtomos[contadorCadena]=palResToken[i];
			   }
             }
			 contadorCadena++;
	       }
{simesp}  {fprintf(archSal,"4 %s\n",yytext);
			cadAtomos[contadorCadena] = yytext[0];
			contadorCadena++;
		   }
{cadena}  {fprintf(archSal,"5 ");
           fprintf(archSal,"%d\n",cadenaalm(yytext));
	       contcadena++;
		   cadAtomos[contadorCadena] = '"';
		   contadorCadena++;
	   	   }
{oparit}  {fprintf(archSal,"6 %s\n",yytext);
			cadAtomos[contadorCadena] = yytext[0];
			contadorCadena++;
		  }
{decima}  {fprintf(archSal,"7 %s\n",yytext);
			cadAtomos[contadorCadena] = 'e';
			contadorCadena++;
			}
{octals}  {fprintf(archSal,"7 %s\n",yytext);
			cadAtomos[contadorCadena] = 'e';
			contadorCadena++;
		   }
{hexade}  {fprintf(archSal,"7 %s\n",yytext);
			cadAtomos[contadorCadena] = 'e';
			contadorCadena++;
			}
{reales}  {fprintf(archSal,"8 %s\n",yytext);
			cadAtomos[contadorCadena] = 'r';
			contadorCadena++;
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
			fprintf(archTI,"%d %s %d \n",tsimbolos[i].posicion, tsimbolos[i].nombre, cadTipos[i]);
			if(cadTipos[i] == -1){
				printf("\nLa variable: %s - no fue declarada",tsimbolos[i].nombre);
			}
		} 
		for(i = 0; i < (contcadena); i++){
				fprintf(archTC,"%d %s\n",tcadenas[i].posicion,tcadenas[i].str);
			}
	} //El algoritmos a pesar de tener dos fors sigue siendo de complejidad O(n)
	
void mostrarCadAtomos(){
	cadAtomos[contadorCadena++] = '#';
	int i = 0;
	for(i=0;i<500;i++){
		printf("%c",cadAtomos[i]);
	}
	printf("\n");
}

//aqui empieza la parte del analizador sintatctico

void p11(){
	//printf("funcion p11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == 'a'){
		fun11();
		lf11();
		return;
	}else{
		printf("Algo anda mal, esperaba un identificador\n");
		printf("funcion p11\n");
	}
}

void lf11(){
	//printf("funcion lf11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena] == 'a'){
		contadorCadena++;
		fun11();
		lf11();
		return;
	}else if(cadAtomos[contadorCadena] == '#'){
		return;
	}else{
		printf("%c\n",cadAtomos[contadorCadena]);
		printf("Algo anda mal, esperaba un identificador\n");
		printf("funcion lf11\n");
	}
}

//ESTA FUNCION PODRIA TENER UN ERROR POR LA AUSENCIA DE RETURN
void fun11(){
	//printf("funcion fun11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena] == 'a'){
		contadorCadena++;
		if (cadAtomos[contadorCadena] == '('){
			contadorCadena++;
			arg11();
			if(cadAtomos[contadorCadena] == ')'){
				contadorCadena++;
				if(cadAtomos[contadorCadena] == ':'){
					contadorCadena++;
					tipo11();
					if(cadAtomos[contadorCadena] == '['){
						contadorCadena++;
						bs11();
						if(cadAtomos[contadorCadena] == ']'){
							contadorCadena++;
						}else{
							printf("Esperaba un corchete que cierra\n");
							printf("funcion fun11\n");
						}
					}else{
						printf("Esperaba un corchete que abre\n");
						printf("funcion fun11\n");
					}
				}
			}else{
				printf("Esperaba un parentesis que cierra\n");
				printf("funcion fun11\n");
			}
		}else{
			printf("Estaba espernado un parentesis que abre\n");
			printf("funcion fun11\n");
		}
	return;
	}else{
		printf("Esperaba un identificador\n");
		printf("funcion fun11\n");
	}
}

void arg11(){
	//printf("funcion arg11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena] == 'a'){
		contadorCadena++;
		if (cadAtomos[contadorCadena] == ':'){
			contadorCadena++;
			tipo11();
			la11();
			return;
		}else{
			printf("Esperaba dos puntos\n");
			printf("funcion arg11\n");
		}
	}else if(cadAtomos[contadorCadena] == ')'){
		return;
	}else{
		printf("Esperaba un identificador\n");
		printf("funcion arg11\n");
	}
}

//este se llama li
void la11(){
	//printf("funcion la11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == ','){
		contadorCadena++;
		if(cadAtomos[contadorCadena] == 'a'){
			contadorCadena++;
			if(cadAtomos[contadorCadena] == ':'){
				contadorCadena++;
				tipo11();
				la11();
			}else{
				printf("Esperaba dos puntos\n");
				printf("funcion la11\n");
			}
		}else{
			printf("Esperaba un identificador\n");
			printf("funcion la11\n");
		}
	return;
	}else if(cadAtomos[contadorCadena] == ')'){
		return;
	}else{
		printf("Esperaba una coma\n");
		printf("funcion la11\n");
	}
}

void tipo11(){
	//printf("funcion tipo11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena]== 'o' || cadAtomos[contadorCadena]== 't' || cadAtomos[contadorCadena]== 'x'){
		contadorCadena++;
		return;
	}else{
		printf("Esperaba una constante numerica");
		printf("funcion la11\n");
	}
}
//En esta funcion puede ser que falten ":"
void bs11(){
	//printf("funcion bs11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena]== 'o' || cadAtomos[contadorCadena]== 't' || cadAtomos[contadorCadena]== 'x' || cadAtomos[contadorCadena]== 'a' || cadAtomos[contadorCadena]== 'w' || cadAtomos[contadorCadena]== 'h' || cadAtomos[contadorCadena]== 'f' || cadAtomos[contadorCadena]== 'i'){
		s11();
		ls11();
		return;
	}else{
		printf("Encuentro un error\n");
		printf("funcion bs11\n");
	}
	return;
}

//En esta funcion puede ser que falten ":"
void ls11(){
	//printf("funcion ls11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena]== 'o' || cadAtomos[contadorCadena]== 't' || cadAtomos[contadorCadena]== 'x' || cadAtomos[contadorCadena]== 'a' || cadAtomos[contadorCadena]== 'w' || cadAtomos[contadorCadena]== 'h' || cadAtomos[contadorCadena]== 'f' || cadAtomos[contadorCadena]== 'i'){
		s11();
		ls11();
		return;
	}else if(cadAtomos[contadorCadena]== ']'){
		return;
	}else{
		printf("No esperaba esta entrada\n");
		printf("funcion ls11\n");
	}
}

//checar return
void s11(){
	//printf("funcion s11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena]== 'o' || cadAtomos[contadorCadena]== 't' || cadAtomos[contadorCadena]== 'x'){
		dec11();
		return;
	}else if(cadAtomos[contadorCadena]== 'a'){
		asig11();
		return;
	}else if (cadAtomos[contadorCadena]== 'w'){
		m11();
		return;	
	}else if(cadAtomos[contadorCadena]== 'h'){
		h11();
		return;
	}else if(cadAtomos[contadorCadena]== 'f'){
		para11();
		return;
	}else if(cadAtomos[contadorCadena]== 'i'){
		si11();
		return;
	}else{
		printf("No esperaba esa entrada\n");
		printf("funcion s11\n");
	}
}

void dec11(){
	//printf("funcion dec11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena]== 'o' || cadAtomos[contadorCadena]== 't' || cadAtomos[contadorCadena]== 'x'){
		tipo11();
		if(cadAtomos[contadorCadena] == ':'){
			contadorCadena++;
			if(cadAtomos[contadorCadena] == 'a'){
				contadorCadena++;
				li11();
			}else{
				printf("Esperaba un identificador\n");
				printf("funcion dec11\n");
			}
		}else{
			printf("Esperaba dos puntos\n");
			printf("funcion dec11\n");
		}
	}else{
		printf("No esperaba esta entrada\n");
		printf("funcion dec11\n");
	}
}

void li11(){
	//printf("funcion li11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == ','){
		contadorCadena++;
		if (cadAtomos[contadorCadena] == 'a'){
			li11();
			return;
		}else{
		}
	// otxawhfi]
	}else if(cadAtomos[contadorCadena]== 'o' || cadAtomos[contadorCadena]== 't' || cadAtomos[contadorCadena]== 'x' || cadAtomos[contadorCadena]== 'a' || cadAtomos[contadorCadena]== 'w' || cadAtomos[contadorCadena]== 'h' || cadAtomos[contadorCadena]== 'f' || cadAtomos[contadorCadena]== 'i' || cadAtomos[contadorCadena]== ']'){
		return;
	}else{
		printf("No esperaba esta entrada\n");

	}
}

void asig11(){
	//printf("funcion asig11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena] == 'a'){
		contadorCadena++;
		opAsig11();
		e11();
		if(cadAtomos[contadorCadena] == ';'){
			contadorCadena++;
			return;
		}else{
			printf("Esperaba punto y coma\n");
			printf("funcion asig11\n");
		}
	}else{
		printf("Esperaba un identificador\n");
	}
}


void opAsig11(){
	//printf("funcion opAsig11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena] == '='){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 'm'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 'n'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 'p'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 'd'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 's'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == '&'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == '^'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == '|'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 'y'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 'z'){
		contadorCadena++;
		return;
	}else if(cadAtomos[contadorCadena] == 'm'){
		contadorCadena++;
		return;
	}else{
		printf("Esperaba un identificador diferente\n");
		printf("opAsig11\n");
	}
}

void m11(){
	//printf("funcion m11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == 'w'){
		contadorCadena++;
		if(cadAtomos[contadorCadena] == '('){
			contadorCadena++;
			er11();
			if(cadAtomos[contadorCadena] == ')'){
				contadorCadena++;
				if (cadAtomos[contadorCadena]== '['){
					contadorCadena++;
					bs11();
					if (cadAtomos[contadorCadena] == ']'){
						contadorCadena++;
					}else{
						printf("Esperaba un corchete de cerradura\n");
						printf("funcion m11\n");
					}
				}else{
					printf("Esperaba un parentesis cuadrado de cerradura\n");
					printf("funcion m11\n");
				}
			}else{
				printf("Esperaba un parentesis de cerradura\n");
				printf("funcion m11\n");
			}
		}else{
			printf("Esperaba un parentesis\n");
			printf("funcion m11\n");
		}
		return;
	}
}

void h11(){
	//printf("funcion h11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == 'h'){
		contadorCadena++;
		if(cadAtomos[contadorCadena] == '['){
			contadorCadena++;
			bs11();
			if(cadAtomos[contadorCadena] == ']'){
				contadorCadena++;
				if(cadAtomos[contadorCadena] == 'w'){
					contadorCadena++;
					if(cadAtomos[contadorCadena] == '('){
						contadorCadena++;
						er11();
						if(cadAtomos[contadorCadena] == ')'){
							contadorCadena++;
							if(cadAtomos[contadorCadena] == ';'){
								contadorCadena++;
							}else{
								printf("Esperaba dos puntos\n");
								printf("funcion h11\n");
							}
						}else{
							printf("Esperaba parentesis de cerradura\n");
							printf("funcion h11\n");
						}
					}else{
						printf("Esperaba parentesis\n");
						printf("funcion h11\n");
					}
				}else{
					printf("No era la entrada que esperaba \n");
					printf("funcion h11\n");
				}
			}else{
				printf("Esperaba corchetes de cerradura\n");
				printf("funcion h11\n");
			}
		}else{
			printf("Esperaba corchetes de apertura\n");
			printf("funcion h11\n");
		}
	}else{
		printf("No era la entrada que esperaba \n");
		printf("funcion h11\n");
	}
}

void para11(){
	//printf("funcion para11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
		if(cadAtomos[contadorCadena] == 'f'){
		contadorCadena++;
		if(cadAtomos[contadorCadena] == '('){
			contadorCadena++;
			asig11();
			er11();
			if(cadAtomos[contadorCadena] == ';'){
				contadorCadena++;
				asig11();
				if(cadAtomos[contadorCadena] == ')'){
					contadorCadena++;
					if(cadAtomos[contadorCadena] == '['){
						contadorCadena++;
						bs11();
						if(cadAtomos[contadorCadena] == ']'){
							contadorCadena++;
						}else{
							printf("Esperaba corchetes de cerradura\n");
							printf("funcion para11\n");
						}
					}else{
						printf("Esperaba corchetes de apertura\n");
						printf("funcion para11\n");
					}
				}else{
					printf("Esperaba parentesis de cerradura \n");
					printf("funcion para11\n");
				}
			}else{
				printf("Esperaba dos puntos\n");
				printf("funcion para11\n");
			}
		}else{
			printf("Esperaba parentesis de apertura\n");
			printf("funcion para11\n");
		}
	}else{
		printf("No era la entrada que esperaba \n");
		printf("funcion para11\n");
	}
}


void si11(){
	//printf("funcion si11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == 'i'){
		contadorCadena++;
		er11();
		if(cadAtomos[contadorCadena] == '['){
			contadorCadena++;
			bs11();
			if(cadAtomos[contadorCadena] == ']'){
				contadorCadena++;
				if(cadAtomos[contadorCadena] == 'j'){
					contadorCadena++;
					if(cadAtomos[contadorCadena] == '['){
						contadorCadena++;
						bs11();
						if(cadAtomos[contadorCadena] == ']'){
							contadorCadena++;
						}else{
							printf("Esperaba un corchete de cerradura\n");
							printf("funcion si11\n");
						}
					}else{
							printf("Esperaba un corchete de apertura\n");
							printf("funcion si11\n");
					}
				}else{
					printf("No era la entrada que esperaba\n");
					printf("funcion si11\n");
				}
			}else{
				printf("Esperaba un corchete de cerradura\n");
				printf("funcion si11\n");
			}
		}else{
			printf("Esperaba un corchete de apertura\n");
			printf("funcion si11\n");
		}
	return;
	}else{
		printf("No era la entrada que esperaba\n");
		printf("funcion si11\n");
	}
}

void er11(){
	//printf("funcion er11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == '(' || cadAtomos[contadorCadena] == 'a' || cadAtomos[contadorCadena] == 'e' || cadAtomos[contadorCadena] == 'r'){
		e11();
		erc11();
		return;
	}else{
		printf("No era la entrada que esperaba\n");
		printf("funcion er11\n");
	}
}

//{>g<lq!} 
// );[

void erc11(){
	//printf("funcion erc11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == '>' || cadAtomos[contadorCadena] == 'g' || cadAtomos[contadorCadena] == '<' || cadAtomos[contadorCadena] == 'l' || cadAtomos[contadorCadena] == 'q'|| cadAtomos[contadorCadena] == '!'){
		opr11();
		e11();
		return;
	}else if (cadAtomos[contadorCadena] == ')' || cadAtomos[contadorCadena] == ';' || cadAtomos[contadorCadena] == '['){
		return;
	}else{
		printf("No era la entrada que esperaba\n");
		printf("funcion erc11\n");
	}
}

void opr11(){
	//printf("funcion opr11\n");
	//printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == '>' || cadAtomos[contadorCadena] == 'g' || cadAtomos[contadorCadena] == '<' || cadAtomos[contadorCadena] == 'l' || cadAtomos[contadorCadena] == 'q'|| cadAtomos[contadorCadena] == '!'){
		contadorCadena++;
	}else{
		printf("No era la entrada que esperaba\n");
		printf("funcion opr11\n");
	}
}

//BIEN

void e11(){
	//printf("funcion e11\n");
	//printf("%c\n",cadAtomos[contadorCadena] );
	if(cadAtomos[contadorCadena] == '(' || cadAtomos[contadorCadena] == 'a' || cadAtomos[contadorCadena] == 'e'|| cadAtomos[contadorCadena] == 'r'){
		t11();
		ep11();
		return;
	}else{
		printf("No era la entrada que esperaba\n");
	}
}

//BIEN
//revisar los dos puntos
void ep11(){
	//printf("entro eP11\n");
	//printf("%c\n",cadAtomos[contadorCadena] );
	if(cadAtomos[contadorCadena] == '+' || cadAtomos[contadorCadena] == '-'){
		contadorCadena++;
		t11();
		ep11();
		return;
	}else if(cadAtomos[contadorCadena] == '>' || cadAtomos[contadorCadena] == 'g' || cadAtomos[contadorCadena] == '<' || cadAtomos[contadorCadena] == 'l' || cadAtomos[contadorCadena] == 'q' || cadAtomos[contadorCadena] == '!' || cadAtomos[contadorCadena] == ')' || cadAtomos[contadorCadena] == ';' || cadAtomos[contadorCadena] == '['){
		return;
	}else{
		printf("funcion ep11\n");
	}
}

//BIEN
void t11(){
	//printf("Entro a t11\n");
	//printf("%c\n",cadAtomos[contadorCadena] );
	if(cadAtomos[contadorCadena] == '(' || cadAtomos[contadorCadena] == 'a' || cadAtomos[contadorCadena] == 'e'|| cadAtomos[contadorCadena] == 'r'){
		f11();
		tp11();
		return;
	}else{
		printf("funcion t11\n");
	}
}


void tp11(){
	//printf("Entro tp11\n");
	//printf("%c\n",cadAtomos[contadorCadena] );
	if (cadAtomos[contadorCadena] ==  '*' || cadAtomos[contadorCadena] ==  '/' || cadAtomos[contadorCadena] ==  '%' ){
		contadorCadena++;
		f11();
		tp11();
		return;
	}else if(cadAtomos[contadorCadena] == '+' || cadAtomos[contadorCadena] == '-' ||cadAtomos[contadorCadena] == ';' || cadAtomos[contadorCadena] == '>' || cadAtomos[contadorCadena] == 'g' || cadAtomos[contadorCadena] == '<' || cadAtomos[contadorCadena] == 'l' || cadAtomos[contadorCadena] == 'q' || cadAtomos[contadorCadena] == '!' || cadAtomos[contadorCadena] == ')' || cadAtomos[contadorCadena] == '['){
		return;
	}else{
		printf("error4\n");
	}
}


void f11(){
	//printf("entro f11\n");
	//printf("%c\n",cadAtomos[contadorCadena] );
	if(cadAtomos[contadorCadena] == '('){
		contadorCadena++;
		e11();
		if (cadAtomos[contadorCadena] == ')'){
			contadorCadena++;
		}else{
			printf("error5\n");
		}
	}else if (cadAtomos[contadorCadena] == 'a' || cadAtomos[contadorCadena] == 'e' || cadAtomos[contadorCadena] == 'r'){
		contadorCadena++; // revisar este 
		return;
	}else{
		printf("error6\n");
	}
}


void anSint(){
	contadorCadena = 0;
	//printf("entro anSint\n");
	p11();
	//contadorCadena++;
	//printf("%c\n",cadAtomos[contadorCadena] );
	if (cadAtomos[contadorCadena] == '#')
	{
		printf("LO ACEPTE");
	}else{
		printf("LO RECHACE\n");
	}
}

void obtenerTipo(){
	
	int i = 0;
	int j,k,l,var;
	for(i=0;i<500;i++){
		if(cadAtomos[i] == 'a'){
			j = i + 1; 
			if(cadAtomos[j] == '('){
				for(k=j;k<500;k++){
					//printf("Si entro %d", k);
					if(cadAtomos[k] == ')'){
						k++;
						if(cadAtomos[k] == ':'){
							if(cadAtomos[k+1] == 't'){
								//printf("\n entero");
								cadTipos[contadorTipo]= 1;
								contadorTipo++;
								break;
							}
							if(cadAtomos[k+1] == 'o'){
								//printf("\n doble");
								cadTipos[contadorTipo]= 0;
								contadorTipo++;
								break;
							}
							if(cadAtomos[k+1] == 'x'){
								//printf("\n real");
								cadTipos[contadorTipo]= 5;
								contadorTipo++;
								break;
							}					
						}
					}
				}
			}			
			else if(cadAtomos[j] == ':'){
				if(cadAtomos[j+1] == 't'){
					//printf("\n entero");
					cadTipos[contadorTipo]= 1;
					contadorTipo++;
				}
				if(cadAtomos[j+1] == 'o'){
					//printf("\n doble");
					cadTipos[contadorTipo]= 0;
					contadorTipo++;
				}
				if(cadAtomos[j+1] == 'x'){
					//printf("\n real");
					cadTipos[contadorTipo]= 5;
					contadorTipo++;
				}				
			}
			else{
				l = i-1;
				if(cadAtomos[l] == ':' || cadAtomos[l] == ','){
					for(k=l;k>1;k--){
						k--;
						if(cadAtomos[k] == 't'){
								//printf("\n entero");
								cadTipos[contadorTipo]= 1;
								contadorTipo++;
								break;
						}
						if(cadAtomos[k] == 'o'){
								//printf("\n doble");
								cadTipos[contadorTipo]= 0;
								contadorTipo++;
								break;
						}
						if(cadAtomos[k] == 'x'){
								//printf("\n real");
								cadTipos[contadorTipo]= 5;
								contadorTipo++;
								break;
						}					
					}
				}
			}
			
		}
		
	}
	for(i=contadorTipo;i<100;i++){
		cadTipos[i]= -1;
	}
	
}

void tipos(){
	int i;
	char ch;	
	rewind(archTI);
	i=0;
	while(1)
	    {
			for(i=0;i<contadorTipo;i++){
				printf("%d \n",cadTipos[i]);
			}
	    }
		printf("esta es la i: %d",i);
}


void traductor(){
	char str1[90], str2[40], str3[20];
	int caracter,buffer,i,j,bandera=0;
	char *token;	
	rewind(yyin);
	printf("\n");
	
	while((caracter = fscanf(yyin,"%s",str1)) != EOF){
		for(i=0;i<90;i++){
			if(str1[i] == '['){
				str1[i] = '{';
			}
			if(str1[i] == ']'){
				str1[i] = '}';
			} 
		}
		if(bandera == 0){
			fprintf(archTRA,"%s\n",str1);
			bandera = 0;			
			}else{
				bandera = 0;
			}

    }
	
}





int main(int argc, char *argv[]) //funcion Main
   {
     yyin = fopen(argv[1],"r"); //escritura en archivo
     archSal = fopen("salida.txt","w");//escritura en archivo
	 archErr = fopen("errores.txt","w");//escritura en archivo
	 archTI = fopen("TablaSimbolos.txt","w");//escritura en archivo
	 archTC = fopen("TablaCadenas.txt","w");//escritura en archivo
	 archTRA = fopen("ProgramTraducido.txt","w");//escritura en archivo
     yylex(); //usa funcion yylex
     fclose(archSal); //cierra el archivo
	 printf("Esta es la cadena de Atomos \n");
	 mostrarCadAtomos();
	 obtenerTipo();
	 imprime();
	 traductor();
	 //printf("Resultado del analizador Sintactico: \n");
	 anSint();
	 printf("\n");
	 //mostrarCadAtomos();
}
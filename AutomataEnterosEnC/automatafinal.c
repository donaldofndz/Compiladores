/*
ALUMNO: JOSÉ DONALDO FERNÁNDEZ MONTENEGRO 
COMPILADORES
PROGRAMA PARA PUNTOS EXTRAS
GRUPO 02 
*/

#include <stdio.h> 			//Se Agregan Librerias
#include <stdlib.h> 			//Se Agregan Librerias
#include <string.h> 			//Se Agregan Librerias


/*
FUNCION QUE DEFINE EL TIPO DE NUMERO QUE SE ESTA VALUANDO HEXADECIMAL, DECIMAL U OCTAL
LA FIRMA DE LA FUNCIÓN ES LA SIGUIENTES

valuadorTipo(char,char,char,arreglo);

*/

void valuadorTipo(char primer, char segundo, char tercer, char * arreglo) {

  int pCas, sCas, tCas, banderaO, banderaD, banderaH; //DECLARACION DE VARIABLES 
  pCas = (int * )(size_t) primer; //CASTEO DE VARIABLES A INT
  sCas = (int * )(size_t) segundo; //CASTEO DE VARIABLES A INT 
  tCas = (int * )(size_t) tercer; //CASTEO DE VARIABLES A INT

  banderaO = verificaOctal(arreglo);  //ASIGNACION DE VARIABLES CASTEADAS
  banderaD = verificaDecimal(arreglo); //ASIGNACION DE VARIABLES CASTEADAS
  banderaH = verificaHex(arreglo); //ASIGNACION DE VARIABLES CASTEADAS

  if (pCas == 48 && sCas == NULL) {  //VALUA QUE EXISTA 0
    printf("Ingresaste un cero\n"); //IMPRIME CADENA
  } else if (pCas == 48 && banderaO == 0) { //VALUA QUE 
    if (sCas == 48 || sCas == 85 || sCas == 117 || sCas == 76 || sCas == 108) { //VALUA SI PUEDE O NO RECONOCER CADENA
      printf("No puedo reconocer esta cadena\n"); //IMPRIME CADENA
      exit(1);  //SALE DEL PROGRAMA
    }
    if (tCas == NULL) { //VALUA VARIABLE CASTEADA
      printf("No puedo reconocer esta cadena\n"); //IMPRIME CADENA
      exit(1); //SALE DEL PROGRAMA 
    } else {
      printf("Es Octal "); //IMPRIME RESULTADO
    }

  } else if (pCas == 48 && sCas == 88 && banderaH == 0 || pCas == 48 && sCas == 120 && banderaH == 0) { //VALUA SI RECONOCE CADENA
    if (tCas == NULL || tCas == 85 || tCas == 117 || tCas == 76 || tCas == 108) {//VALUA SI RECONOCE CADENA
      printf("No puedo reconocer esta cadena\n\n");//IMPRIME RESULTADO
      exit(1);
    } else {
      printf("Es Hexadecimal ");//IMPRIME RESULTADO
    }
  } else if (pCas != 48 && banderaD == 0) {//VALUA SI RECONOCE CADENA
    printf("Es Decimal ");//IMPRIME RESULTADO

  } else {
    printf("No puedo reconocer esta cadena\n");//IMPRIME RESULTADO
    exit(1);
  }

}


/*
Funcion que verifica si todos los caracteres de una cadena pertenecen al alfabeto octar 
firma de la funcion verificaOctal(arreglo)
*/

int verificaOctal(char * arreglo) {
  int i, casVerificar, regreso = 0;//DECLARACION DE 
  for (i = 0; i < strlen(arreglo); i++) {//RECORRE CARACTERES DE CADENA BUSCANDO ALFABETO
    casVerificar = (int * )(size_t) arreglo[i];//GUARDA Y VERIFICA PERTENENCIA

    if (casVerificar >= 48 && casVerificar <= 55 || casVerificar == 117 || casVerificar == 85 || casVerificar == 76 || casVerificar == 108) {} else {//VALUA SI RECONOCE CADENA
      regreso = 1;
    }
  }
  return regreso;
}

/*
Funcion que verifica si todos los caracteres de una cadena pertenecen al alfabeto Decimal 
firma de la funcion verificaDecimal(arreglo)
*/

int verificaDecimal(char * arreglo) {
  int i, casVerificar, regreso = 0;//DECLARACION DE 
  for (i = 0; i < strlen(arreglo); i++) { //RECORRE CARACTERES DE CADENA BUSCANDO ALFABETO
    casVerificar = (int * )(size_t) arreglo[i];//GUARDA Y VERIFICA PERTENENCIA

    if (casVerificar >= 48 && casVerificar <= 57 || casVerificar == 117 || casVerificar == 85 || casVerificar == 76 || casVerificar == 108) {} else { //VALUA SI RECONOCE CADENA
      regreso = 1;
    }
  }
  return regreso;
}


/*
Funcion que verifica si todos los caracteres de una cadena pertenecen al alfabeto Hexadecimal 
firma de la funcion verificaHex(arreglo)
*/

int verificaHex(char * arreglo) {
  int i, casVerificar, regreso = 0;//DECLARACION DE 
  for (i = 0; i < strlen(arreglo); i++) {//RECORRE CARACTERES DE CADENA BUSCANDO ALFABETO
    casVerificar = (int * )(size_t) arreglo[i]; //GUARDA Y VERIFICA PERTENENCIA

    if (casVerificar >= 48 && casVerificar <= 57 || casVerificar >= 65 && casVerificar <= 70 || casVerificar >= 97 && casVerificar <= 102 || casVerificar == 117 || casVerificar == 85 || casVerificar == 76 || casVerificar == 108 || casVerificar == 88 || casVerificar == 120) {} else {//VALUA SI RECONOCE CADENA
      regreso = 1;
    }
  }
  return regreso;
}

/*
Funcion que verifica las propiedades de un numero entero 
firma de la funcion valuadorEspecial(char,char,char)
*/

void valuadorEspecial(char primer, char segundo, char tercer) {

  int ult, penult, antepe; //DECLARACION DE VARIABLES
  ult = (int * )(size_t) primer;//CASTEO DE VARIABLES
  penult = (int * )(size_t) segundo;//CASTEO DE VARIABLES
  antepe = (int * )(size_t) tercer; //CASTEO DE VARIABLES

  if (ult == penult) {
    printf("No puedo reconocer esta cadena\n");//IMPRIME RESULTADO
  } else {
    if ((penult == 85 || penult == 117) && (ult == 76 || ult == 108)) {//VALUA SI RECONOCE CADENA
      printf("Unsigned and Long\n");//IMPRIME RESULTADO
    } else if (ult == 85 || ult == 117) {//VALUA SI RECONOCE CADENA
      if (penult == 76 || penult == 108) {//VALUA SI RECONOCE CADENA
        printf("No puedo reconocer la cadena\n");//IMPRIME RESULTADO
      } else {
        printf(" Unsigned\n");//IMPRIME RESULTADO
      }
    } else if (ult == 76 || ult == 108) {//VALUA SI RECONOCE CADENA
      printf("Long\n"); //IMPRIME RESULTADO
    }
  }

}

int main(int argc, char
  const * argv[]) {

  int i = 0, valor;//DECLARACION DE 
  char c;//DECLARACION DE 

  char arr[100][20], input[100];//DECLARACION DE 
  FILE * ptr;//DECLARACION DE 
  ptr = fopen(argv[1], "r"); //APUNTADOR QUE ABRE ARCHIVO

  printf("PROGRAMA QUE NOS INDICA EL CARACTER LEXICO DE UN NUMERO ENTERO\n\n"); //PANTALLA DE INSTRUCCIONES DEL PROGRAMA
  printf("PRGRAMA QUE RECIBE CADENAS POR MEDIO DE UN ARCHIVO PASADO EN ARGUEMNTO\n\n");



  while (fscanf(ptr, "%s", arr[i]) != EOF) {  //verifica fin de cadena
    input[0] = '\0'; //SE LIMPIA LA CADENA
    strcpy(input, arr[i]); //SE COPIA LA CADENA
    printf("El numero: %s  ", arr[i]); 	//FORMA PARA IMPRESION EN PANTALLA 

    if (strlen(input) == 0) { //VALIA CONDICION
      printf("No haz ingresado un numero\n"); //CHECA ERROR 
    } else {

      valuadorTipo(input[0], input[1], input[2], input); //PASA VALORES A FUNCIONES ANTES MENCIONADAS
      valor = strlen(input); //PASA VALORES A FUNCIONES ANTES MENCIONADAS
      valuadorEspecial(input[valor - 1], input[valor - 2], input[valor - 3]); //PASA VALORES A FUNCIONES ANTES MENCIONADAS

    }

    printf("\n");//SALTO DE LINEA

  }

  return 0; //FUNCION REGRESA A CERO
}
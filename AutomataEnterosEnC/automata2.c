#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void valuadorTipo(char primer, char segundo, char tercer, char *arreglo){

	int pCas, sCas, tCas,banderaO,banderaD,banderaH;
	pCas = (int *) (size_t) primer;
	sCas = (int *) (size_t) segundo;
	tCas = (int *) (size_t) tercer;

	banderaO = verificaOctal(arreglo);
	banderaD = verificaDecimal(arreglo);
	banderaH = verificaHex(arreglo);

	if(pCas == 48 && sCas == NULL){
		printf("Ingresaste un cero\n");
	}else if(pCas == 48 && banderaO == 0){
		if(sCas==48 || sCas == 85|| sCas == 117 || sCas == 76 || sCas == 108){
			printf("No puedo reconocer esta cadena\n");
			exit(1);
		}
		if(tCas == NULL){
			printf("No puedo reconocer esta cadena\n");
			exit(1);
		}
		else{
			printf("Es Octal");
		}

	}else if(pCas == 48 && sCas == 88 && banderaH == 0 || pCas == 48 && sCas == 120 && banderaH == 0){
		if(tCas == NULL || tCas == 85|| tCas == 117 || tCas == 76 || tCas == 108){
			printf("No puedo reconocer esta cadena\n");
			exit(1);
		}
		else{
			printf("Es Hexadecimal ");
		}
	}else if(pCas!=48 && banderaD == 0){
		printf("Es Decimal ");
		
	}else{
		printf("No puedo reconocer esta cadena\n");
		exit(1);
	}


}

int verificaOctal(char *arreglo){
	int i,casVerificar,regreso=0;
	for (i = 0; i < strlen(arreglo); i++)
	{
		casVerificar = (int *) (size_t) arreglo[i];

		if(casVerificar >= 48 && casVerificar <= 55 || casVerificar == 117 || casVerificar == 85 || casVerificar == 76 || casVerificar ==108){
		}
		else{
			regreso = 1;
		}
	}
	return regreso;
}

int verificaDecimal(char *arreglo){
	int i,casVerificar,regreso=0;
	for (i = 0; i < strlen(arreglo); i++)
	{
		casVerificar = (int *) (size_t) arreglo[i];

		if(casVerificar >= 48 && casVerificar <= 57 || casVerificar == 117 || casVerificar == 85 || casVerificar == 76 || casVerificar ==108){
		}
		else{
			regreso = 1;
		}
	}
	return regreso;
}

int verificaHex(char *arreglo){
	int i,casVerificar,regreso=0;
	for (i = 0; i < strlen(arreglo); i++)
	{
		casVerificar = (int *) (size_t) arreglo[i];

		if(casVerificar >= 48 && casVerificar <= 57 || casVerificar >= 65 && casVerificar <= 70 || casVerificar >= 97 && casVerificar <= 102 || casVerificar == 117 || casVerificar == 85 || casVerificar == 76 || casVerificar ==108 || casVerificar == 88 || casVerificar == 120){
		}
		else{
			regreso = 1;
		}
	}
	return regreso;
}

void valuadorEspecial(char primer, char segundo, char tercer){

	int ult,penult,antepe;
	ult = (int *) (size_t) primer;
	penult = (int *) (size_t) segundo;
	antepe = (int *) (size_t) tercer;

	if(ult == penult){
		printf("No puedo reconocer esta cadena\n");
	}else{
		if ((penult == 85 || penult == 117 )&& (ult == 76 || ult == 108))
		{
			printf("Unsigned and Long\n");
		}else if(ult == 85 || ult == 117){
			if (penult==76 ||penult== 108)
			{
				printf("No puedo reconocer la cadena\n");
			}else{
				printf("%d\n",penult );
				printf("Unsigned\n");
			}
		}else if(ult == 76 || ult == 108){
			printf("Long\n");
		}
	}

}

int main(int argc, char const *argv[]) {

  int i = 0,valor;
  char c, *input;
  input = (char *) malloc(sizeof(char));

  printf("PROGRAMA QUE NOS INDICA EL CARACTER LEXICO DE UN NUMERO ENTERO\n\n");
  printf("Dame el numero a valuar: ");
  
  while((c = getchar()) != '\n') {
    realloc(input, (sizeof(char)));
    input[i++] = c;
  }

  input[i]='\0';

  if(strlen(input) == 0){
  	printf("No haz ingresado un numero\n");
  }else{

  	valuadorTipo(input[0], input[1], input[2], input);
  	valor=strlen(input);
  	valuadorEspecial(input[valor-1], input[valor-2],input[valor-3]);


  }
  	


  return 0;                                                                                                
}   
#include <stdio.h>


int main(int argc, char const *argv[])
{

	int x = 1;

	if(x)
		printf("se cumple\n");
		printf("ya no se va cumplir\n"); //AL SER MÁS DE DOS INSTRUCCIONES EL ANALIZADOR SINTACTICO ESPERA LLAVES PERO SE OMITEN
	else
		printf("aaaaa\n");
	
	return 0;
}
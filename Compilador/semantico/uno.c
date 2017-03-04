#include <stdio.h>


int main(int argc, char const *argv[])
{

	int edad=12;

	if (edad < 18){ //ERROR SEMANTICO, DE LOGICA NADIE CON MENOS DE 18 PUEDE COMPRAR CERVEZA
		printf("ya puedes comprar cerveza\n");
	}


	return 0;
}
#include <stdio.h>

int main(int argc, char const *argv[])
{
	
	int variable;

	variable: 4; //ERROR LEXICO DEL PROGRAMA AL NO RECONOCER LOS DOS PUNTOS COMO OPERADOR ASIGNACION

	printf("%d\n", variable);
	return 0;
}
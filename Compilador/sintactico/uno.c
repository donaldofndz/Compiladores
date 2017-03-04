#include <stdio.h>


int main(int argc, char const *argv[])
{
	int base= 2, altura = 2, area;

	area = (base)(altura);//SE UTILIZA LENGUAJE ALGEBRAICO PARA MULTIPLICACION, PERO EL ANALIZADOR SINTACTICO NO ENTIENDE ESTE LENGUAJE 

	printf("%d\n",area);


	return 0;
}
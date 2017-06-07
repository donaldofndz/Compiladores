#include <stdio.h>


char cadAtomos[] = {'a','+','a','#'};
int contadorCadena = 0;


void e11();
void t11();
void ep11();
void tp11();
void f11();
void anSint();

//BIEN

void e11(){
	printf("funcion e11\n");
	printf("%c\n",cadAtomos[contadorCadena] );
	if(cadAtomos[contadorCadena] == '(' || cadAtomos[contadorCadena] == 'a' || cadAtomos[contadorCadena] == 'e'|| cadAtomos[contadorCadena] == 'r'){
		t11();
		ep11();
		return;
	}else{
		printf("funcion e11\n");
	}
}

//BIEN
//revisar los dos puntos
void ep11(){
	printf("entro eP11\n");
	printf("%c\n",cadAtomos[contadorCadena] );
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
	printf("Entro a t11\n");
	printf("%c\n",cadAtomos[contadorCadena] );
	if(cadAtomos[contadorCadena] == '(' || cadAtomos[contadorCadena] == 'a' || cadAtomos[contadorCadena] == 'e'|| cadAtomos[contadorCadena] == 'r'){
		f11();
		tp11();
		return;
	}else{
		printf("funcion t11\n");
	}
}


void tp11(){
	printf("Entro tp11\n");
	printf("%c\n",cadAtomos[contadorCadena] );
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
	printf("entro f11\n");
	printf("%c\n",cadAtomos[contadorCadena] );
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
	printf("entro anSint\n");
	e11();
	//contadorCadena++;
	printf("%c\n",cadAtomos[contadorCadena] );
	printf("%d\n",contadorCadena );
	if (cadAtomos[contadorCadena] == '#')
	{
		printf("LO ACEPTE");
	}else{
		printf("LO RECHACE\n");
	}
}



int main(int argc, char const *argv[])
{

	anSint();
	return 0;
}



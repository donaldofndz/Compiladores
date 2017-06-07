#include <stdio.h>


char cadAtomos[] = {'a','(','a',':','x',')',':','t','[','o',':','a',',','o',':','a','f','(','a','=','e',';','a','<','e',';','a','m','e',';',')','[','a','=','a','*','e',';',']',']','#'};
//{'a','(','a',':','x',')',':','t','[','a',',','a',':','o','f','(','a','=','e',';','a','<','e',';','a','m','e',';',')','[','a','=','a','*','e',';','"',']',']'}
//{'a','(','a',':','x',')',':','t','[','a',':','o','a',':','o','f','(','a','=','e',';','a','<','e',';','a','m','e',';',')','[','a','=','a','*','e',';',']',']'};
//{'a','(','a',':','x',')',':','t','[','o',':','a',',','o',':','a','f','(','a','=','e',';','a','<','e',';','a','m','e',';',')','[','a','=','a','*','e',';',']',']'}
// a(a:x):t[a:o,a:of(a=e;a<e;ame;)[a=a*e;]]
// a(a:x):t[a,a:of(a=e;a<e;ame;)[a=a*e;"]]
int contadorCadena = 0;


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

void p11(){
	printf("funcion p11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion lf11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
	if (cadAtomos[contadorCadena] == 'a'){
		contadorCadena++;
		fun11();
		lf11();
		return;
	}else if(cadAtomos[contadorCadena] == '#'){
		return;
	}else{
		printf("Algo anda mal, esperaba un identificador\n");
		printf("funcion lf11\n");
	}
}

//ESTA FUNCION PODRIA TENER UN ERROR POR LA AUSENCIA DE RETURN
void fun11(){
	printf("funcion fun11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion arg11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion la11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion tipo11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion bs11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion ls11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion s11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion dec11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion li11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion asig11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion opAsig11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion m11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion h11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion para11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion si11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion er11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion erc11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
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
	printf("funcion opr11\n");
	printf("%c\n",cadAtomos[contadorCadena]);
	if(cadAtomos[contadorCadena] == '>' || cadAtomos[contadorCadena] == 'g' || cadAtomos[contadorCadena] == '<' || cadAtomos[contadorCadena] == 'l' || cadAtomos[contadorCadena] == 'q'|| cadAtomos[contadorCadena] == '!'){
		contadorCadena++;
	}else{
		printf("No era la entrada que esperaba\n");
		printf("funcion opr11\n");
	}
}

//BIEN

void e11(){
	printf("funcion e11\n");
	printf("%c\n",cadAtomos[contadorCadena] );
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
	p11();
	//contadorCadena++;
	printf("%c\n",cadAtomos[contadorCadena] );
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

%{
	/*
	
		Posibles soluciones para problemas con MAC y flex 
		La forma de compilar es la siguiente gcc lex.yy.c -ll
		Pasar como parametro en el programa %option noyywrap
	*/
	
	
	
/* Programa que lee un programa y hace el
   reconocimiento de identificadores,
   palabras reservadas y enteros de un
   lenguaje x
*/

%}

%%

%%
main(int argc, char *argv[])
   {
	   printf("Hola");
}
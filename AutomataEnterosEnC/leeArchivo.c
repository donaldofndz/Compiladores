#include <stdio.h>
#include <string.h>




int main(int argc, char const *argv[])
{
  int  i = 0,n,f=0;
  char arr[100][20], copia[100];
  FILE *ptr;
  ptr = fopen(argv[1], "r");

  while(fscanf(ptr, "%s",arr[i]) != EOF){
  	strcpy(copia,arr[i]);
  	
  	printf("%s  length:%d\n",arr[i],(int)strlen(arr[i]));

  }
  	
  return 0;
}


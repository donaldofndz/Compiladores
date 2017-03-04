#include <stdio.h>
#include <stdlib.h>

/*

char *inputString(FILE* fp, size_t size){
    char *str;
    int ch;
    size_t len = 0;
    str = realloc(NULL, sizeof(char)*size);//size is start size
    if(!str)return str;
    while(EOF!=(ch=fgetc(fp)) && ch != '\n'){
        str[len++]=ch;
        if(len==size){
            str = realloc(str, sizeof(char)*(size+=16));
            if(!str)return str;
        }
    }
    str[len++]='\0';

    return realloc(str, sizeof(char)*len);
}

int main(void){
    char *m;

    printf("input string : ");
    m = inputString(stdin, 10);
    printf("%s\n", m);

    free(m);
    return 0;
}

*/

int main()
{
    unsigned int len_max = 128;
    unsigned int current_size = 0;
    
    char *pStr = malloc(len_max);
    current_size = len_max;

    printf("\nEnter a very very very long String value:");

    if(pStr != NULL)
    {
	int c = EOF;
	unsigned int i =0;
        //accept user input until hit enter or end of file
	while (( c = getchar() ) != '\n' && c != EOF)
	{
		pStr[i++]=(char)c;

		//if i reached maximize size then realloc size
		if(i == current_size)
		{
                        current_size = i+len_max;
			pStr = realloc(pStr, current_size);
		}
	}

	pStr[i] = '\0';

        printf("\nLong String value:%s \n\n",pStr);
        //free it 
	free(pStr);
	pStr = NULL;


    }
    return 0;
}
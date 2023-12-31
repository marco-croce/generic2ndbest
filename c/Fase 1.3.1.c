/*
	Generic 2nd Best Attività Didattica LPS

	Fase 1.3.1

	Language: C99
 	Style: plain C
 	Version: C
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int intcmp(char *a, char *b){
    int x,y;
    x = strtol(a,NULL,10);
    y = strtol(b,NULL,10);
    
    printf("X: %i, Y: %i\n",x,y);
    
    return x-y;
}

int doublecmp(char *a, char *b){
    double x,y;
    x = strtod(a,NULL);
    y = strtod(b,NULL);
    
    printf("X: %f, Y: %f\n",x,y);
    
    return x-y;
}

int floatcmp(char *a, char *b){
    float x,y;
    x = strtof(a,NULL);
    y = strtof(b,NULL);
    
    printf("X: %f, Y: %f\n",x,y);
    
    return x-y;
}

int stringcmp(char *a, char *b){
    return strcmp(a,b);
}

void alg_2nd_best(void *comp){
    
}

int main()
{
	
	
    return 0;
}
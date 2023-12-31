/*
	Generic 2nd Best Attività Didattica LPS

	Fase 1.3.2

	Language: C99
 	Style: plain C
 	Version: C
*/

#include <stdio.h>
#include <string.h>

int str_comparator(void *a, void *b){
    
    return strcmp(*(char **) &a, *(char **) &b);
}

int int_comparator(void *a, void *b){
    int *x,*y;
    x=(int *)a;
    y=(int *)b;
    return *x-*y;
}

int main()
{
    int a1 = 21, b1 = 12;
    void* p1 = &a1;
    void* p2 = &b1;
    
    printf("Risultato: %i ", int_comparator(p1, p2));

    return 0;
}
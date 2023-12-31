/*
	Generic 2nd Best Attività Didattica LPS

	Fase 1.2.1

	Language: C99
 	Style: plain C
 	Version: C
*/
 
#include <stdio.h>
#include <string.h>

char s1[] = "Project";

void invstr(char a1[], char a2[]){
    
    for( int i = 0 ; i < strlen(a1) ; i++ ){
        a2[i] = a1[strlen(a1)-i-1];
    }

}

int main()
{
    char s2[strlen(s1)];

    invstr(s1,s2);
    printf("%s", s2);

    return 0;
}

/*
	Generic 2nd Best Attività Didattica LPS

	Fase 1.2.2

	Language: C99
 	Style: plain C
 	Version: C
*/
 
#include <stdio.h>

char p[] = "prova";
char t[] = {'t','e','s','t'};
char *s1[7] = { "Test1", "Test2", p, t, NULL, "", "Ciao" };

int main()
{
    char **ptr = NULL;
    
    for(ptr = s1; ptr < s1 + sizeof(s1)/sizeof(s1[0]); ptr++){
        if(*ptr){
            printf("%s\n",*ptr);
        }
    }

    return 0;
}

/*
	Generic 2nd Best Attività Didattica LPS

	Fase 1.2.3

	Language: C99
 	Style: plain C
 	Version: C
*/
 
#include <stdio.h>
#include <string.h>

char *s1, *s2;

int main()
{

    s1 = "ABCD";
    s2 = "XY";
    printf("str1: %s\nstr2: %s\n",s1,s2);
    
    if(strcmp(s1,s2) == 0){
        printf("Le due stringhe sono uguali\n");
    } else if(strcmp(s1,s2) < 0){
        printf("str1 è minore di str2, val: %d\n",strcmp(s1,s2));
    } else if(strcmp(s1,s2) > 0){
        printf("str1 è maggiore di str2, val: %d\n",strcmp(s1,s2));
    }
    
    s2 = "ABC";
    
    if(strcmp(s1,s2) == 0){
        printf("Le due stringhe sono uguali\n");
    } else if(strcmp(s1,s2) < 0){
        printf("str1 è minore di str2, val: %d\n",strcmp(s1,s2));
    } else if(strcmp(s1,s2) > 0){
        printf("str1 è maggiore di str2, val: %d\n",strcmp(s1,s2));
    }

    return 0;
}

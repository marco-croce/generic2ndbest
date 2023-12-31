/*
	Generic 2nd Best Attività Didattica LPS

	Fase 1.3.3

	Language: C99
 	Style: plain C
 	Version: C
*/

#include <stdio.h>
#include <string.h>

char *data[5] = {"ad", "parco", "andromeda", "uno", "simp"};
int a=31, b=2, c=12, d=15, e=245;
int *data2[5] = {&a, &b, &c, &d, &e};

int str_comparator(void *a, void *b){
    return strcmp(*(char **) &a, *(char **) &b);
}

int int_comparator(void *a, void *b){
    int *x,*y;
    x=(int *)a;
    y=(int *)b;
    return *x-*y;
}

void alg_2nd_best(void *p_ar[], size_t arrLen, size_t elemSize, int (*comp)(void*,void*)){
    void *best;
    void *scndBest = NULL;
    
    for(int i = 0;  i < arrLen; i++){
        if(i==0){
            best = p_ar[i];
            scndBest = p_ar[i];
        }
        
        int a = comp(best, p_ar[i]);
        if(a < 0) {
            scndBest = (int)best;
            best = p_ar[i];
        } else if(a > 0){
            if(comp(scndBest,p_ar[i]) < 0){
                scndBest = p_ar[i];
            }
        }
        
    }
    //Print Interi
    //printf("BEST: %i 2ndBest: %i\n", *(int*)best,*(int*)scndBest);
    //Print String
    //printf("BEST: %s 2ndBest: %s\n", best,scndBest);
   
}

int main(){
    int (*comparator[2])( void*, void*) = {str_comparator, int_comparator};
    alg_2nd_best(data, sizeof(data)/sizeof(data[0]), sizeof(char), comparator[0]);
    //alg_2nd_best(data2, sizeof(data2)/sizeof(data2[0]), sizeof(int), comparator[1]);
    return 0;
}
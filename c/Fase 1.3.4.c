/*
	Generic 2nd Best Attività Didattica LPS

	Fase 1.3.4

	Language: C99
 	Style: plain C
 	Version: C
*/

#include <stdio.h>
#include <string.h>

char *data[5] = {"ad", "parco", "andromeda", "uno", "simp"};
int a=31, b=2, c=12, d=15, e=245;
int *data2[5] = {&a, &b, &c, &d, &e};

struct S
{
    long m1;
    char m2;
};

struct S s1 = {28,'f'};
struct S s2 = {18,'e'};
struct S s3 = {20,'b'};
struct S s4 = {10,'c'};

struct S *data3[4] = {&s1, &s2, &s3, &s4};

int stS_comparator(void *a, void *b){
    struct S *x,*y;
    x=(struct S *)a;
    y=(struct S *)b;
    if( x->m1 == y->m1 && x->m2 == y->m2 ){
        printf("EQUALS\n");
        return 0;
    } else if( ( x->m2 < y->m2) || ( (x->m2 == y->m2 ) && ( x->m1 > y->m1 ) ) ){
        printf("X>Y\n");
        return 1;
    } else {
        printf("X<Y\n");
        return -1;
    }
}

int str_comparator(void *a, void *b){
    return strcmp(*(char **) &a, *(char **) &b);
}

int int_comparator(void *a, void *b){
    int *x, *y;
    x = (int *)a;
    y = (int *)b;
    return *x - *y;
}

void alg_2nd_best(void *p_ar[], size_t arrLen, size_t elemSize, int (*comp)(void*,void*)){
    void *best;
    void *scndBest = NULL;
    
    //WORKS WITH INTs, STRINGs AND STRUCT S
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
    //Print Struct S
    printf("BEST: %i, %c 2ndBest: %i,% c\n", ((struct S*)best)->m1,((struct S*)best)->m2,((struct S*)scndBest)->m1,((struct S*)scndBest)->m2);
   
}

int main(){
    int (*comparator[3])( void*, void*) = {str_comparator, int_comparator, stS_comparator};
    //alg_2nd_best(data, sizeof(data)/sizeof(data[0]), sizeof(char), comparator[0]);
    //alg_2nd_best(data2, sizeof(data2)/sizeof(data2[0]), sizeof(int), comparator[1]);
    alg_2nd_best(data3, sizeof(data3)/sizeof(data3[0]), sizeof(struct S), comparator[2]);
    return 0;
}

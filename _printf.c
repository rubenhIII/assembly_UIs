#include <stdio.h>

void _printf(char* msg);
int i = 0;

void _printf(char* msg){
    i++;
    printf("%d", i);
    printf(msg);
}
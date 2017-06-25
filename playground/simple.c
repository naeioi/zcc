#include <stdio.h>
int a;
char *str = "c=%d";
int add(int a, int b) {
    return a+b;
}

int main() {
    a = 1;
    int c = add(a, 2);
    printf(str, c);
    return 0;
}
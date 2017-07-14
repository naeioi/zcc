#include <stdio.h>
int a;
char *str = "c=%d";
int add(int a, int b) {
    return a+b;
}

int main() {
    a = a > 2;
    if(a > 10) {
        return 0;
    }
    int c = add(a, 2);
    printf(str, c);
    return 0;
}
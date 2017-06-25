#include <stdio.h>
int add(int a, int b) {
    return a+b;
}

int main() {
    int c = add(1, 2);
    printf("%d", c);
    return 0;
}
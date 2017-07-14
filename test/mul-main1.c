#include <stdio.h>
int mul(int a, int n);
int fac(int n);
int main() {
    printf("mul(%d, %d) = %d\n", 3, 5, mul(3, 5));
    printf("fac(%d) = %d\n", 10, fac(10));
    return 0;
}
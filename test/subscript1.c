int a, b = 1;
extern int d;
int main() {
    int *p = malloc(10), c = 4;
    a = 1; d = 2; b = 3;
    p[c] = 5;
    printf("p[5]=%d\n", p[5]);
    return 0;
}
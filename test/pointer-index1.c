int* malloc(int);
int main() {
    int *c, b = 5;
    c = malloc(40);
    c[b] = 10;
    printf("c[5]=%d\n", c[5]);
    return 0;
}
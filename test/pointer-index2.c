int* malloc(int);
int main() {
    int n = 10, *a = malloc(n * 4), i;
    a[0] = 1; a[1] = 1;
    for(i = 2; i < n; i++)
        a[i] = a[i-1] + a[i-2];
    for(i = 0; i < n; i++)
        printf("a[%d]=%d\n", i, a[i]);
    return 0;
}
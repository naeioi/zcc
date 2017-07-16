int main() {
    int **a = malloc(8);
    *a = malloc(4);
    **a = 5;
    printf("**a=%d\n", **a);
    return 0;
}
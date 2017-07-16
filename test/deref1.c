int main() {
    int *a = malloc(4);
    *a = 2;
    printf("*a=%d\n", *a);
    return 0;
}
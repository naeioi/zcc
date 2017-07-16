int main() {
    int *a = malloc(40);
    *(a + 1) = 2;
    printf("*(a + 1) = %d\n", *(a+1));
    return 0;
}
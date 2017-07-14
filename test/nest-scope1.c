int nested() {
    int a = 1;
    printf("==== Nested Test ====\n");
    printf("scope1[a=%d]\n", a);
    if(1) {
        int a = 2;
        printf("scope2[a=%d]\n", a);
        if(1) {
            int a = 3;
            printf("scope3[a=%d]\n", a);
        }
    }
    printf("\n");
    return 0;
}


int expr() {
    printf("=== Expr Text ===\n");
    printf("1 * 2 + 3 - (2 * (1 + 2)) = %d. (should be -1)\n\n", 1 * 2 + 3 - (2 * (1 + 2)));
    return 0;
}

int main() {
    nested();
    expr();
    return 0;
}
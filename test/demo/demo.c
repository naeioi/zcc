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
    printf("=== Expr Test ===\n");
    printf("1 * 2 + 3 - (2 * (1 + 2)) = %d. (should be -1)\n\n", 1 * 2 + 3 - (2 * (1 + 2)));
    return 0;
}

/* compute a*n using add */
int mul_for(int a, int n) {
    int i, r = 0;
    for(i = 0; i < n; i++) 
        r = r + a;
    return r;
}

int mul_while(int a, int n) {
    int i = 0, r = 0;
    while(1) {
        if(i >= n) break;
        r = r + a;
        i++;
        continue;
        r = 1234; /* used to test whether continue works or not */
    }
    return r;
}

int loop() {
    printf("=== Loop Test ===\n");
    printf("4 * 5: \n");
    printf("    mul_for(4, 5) = %d\n", mul_for(4, 5));
    printf("  mul_while(4, 5) = %d\n", mul_while(4, 5));
    printf("           4 * 5  = %d\n", 4 * 5);
    printf("\n");
    return 0;
}

int fac(int n) {
    if(n == 1) return 1;
    else return mul_for(fac(n - 1), n);
}

int recursive() {
    printf("=== Recursive Test ===\n");
    printf("10! = %d. (should be %d)\n\n", fac(10), 3628800);
    return 0;
}

int main() {
    nested();
    expr();
    loop();
    recursive();
    return 0;
}
int mul(int a, int n) {
    int i, r = 0;
    for(i = 0; i < n; i++)
        r = r + a;
    return r;
}

int fac(int n) {
    if(n == 1) return 1;
    else return mul(fac(n-1), n);
}

int fac2(int n) {
    int i = 2, r = 1;
    while(1) {
        if(i > n) break;
        r = mul(i, r);
        continue;
        r++; /* useless in practice but here used to test continue */
    }
    return r;
}
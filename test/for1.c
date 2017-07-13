int mul(int a, int cnt) {
    int r = 0, i;
    for(i = 0; cnt < i; i++)
        r = r + a;
    return r;
}
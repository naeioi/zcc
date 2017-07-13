int judge(int a, int b) {
    int c;
    if(a) {
        if(b) c = b;
        c = a + b;
    }
    else {
        c = a + b;
    }
    return c;
}
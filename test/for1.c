int mul(int a, int cnt) {
    int r = 0, i = 0, j;
    while(i < cnt) {
        r = r + a;
        i++;
        for(j = 0; j < 10; j++) {
            r = r + j;
            break;
            continue;
        }
        r = r + 1;
        break;
        continue;
    }
    return r;
}
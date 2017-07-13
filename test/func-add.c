int add(int a, int b) {
    return a + b + 10;
}

int main() {
    int c, d, a;
    c = add(1, 2);
    a = c;
    d = a + c + c;
    return 0;
}
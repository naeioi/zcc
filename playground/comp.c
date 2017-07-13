int comp(int x, int y) {
    int a;
    if(x < y) {
        a = x < y;
    }
    if(x <= y) {
        a = x <= y;
    }
    if(x == y) {
        a = x == y;
    }
    if(x >= y) {
        a = x >= y;
    }
    if(x > y) {
        a = x > y;
    }
    return a;
}

int main()
{
    return comp(1,2);
}
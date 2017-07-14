int nested() {
    
}

int main() {
    int a = 1;
    printf("scope1[a=%d]\n", a);
    if(1) {
        int a = 2;
        printf("scope2[a=%d]\n", a);
        if(1) {
            int a = 3;
            printf("scope3[a=%d]\n", a);
        }
    }
    return 0;
}
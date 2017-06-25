int a;
int b;
int program(int a,int b,int c)
{
	int i;
	int j;
	i=0; 	
	if(a>(b+c))
	{
		j=a+(b*c+1);
	}
	else
	{
		j=a;
	}
	while(i<=100)
	{
		i=j*2;
	}
	return i;
}

int demo(int a)
{
	a=a+2;
	return a*2;
}

void main(void)
{
	int a;
	int b;
	int c;
	a=3;
	b=4;
	c=2;
	a=program(a,b,demo(c))
	return;
}

/*** Lexicon
=-- Internal representation --=
struct token_st {
    enum tk_class_en tk_class;
    char *tk_str;
    value_st *value;
};

enum tk_class_en {
    // keywords 
    TK_INT,
    TK_CHAR,
    TK_VOID,
    TK_RETURN,
    // constant 
    TK_CONST_INT,
    TK_CONST_CHAR,
    TK_CONST_STRING,
    // operator / delimiter 
    TK_OP,
    // others 
    TK_IDENTIFIER
};

union value_st {
    int i;
    char c;
};

=-- Expect debug output --=
()
 */
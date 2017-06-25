/***
 * ZCC - a study purpose compiler for C programming language
 * By keren. naeioi@hotmail.com
 */

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

/* =-- forward declaration --= */
int lex_next();
int lex_getc();

/* =---- utility ----= */
void fexit(const char *format, ...) {
    puts(format);
    exit(0);
}

/* =---- lex ----= */ 

enum lex_ecode_en {
    ELEX_FILE_NULL = 1,
    ELEX_FEOF
};

/* -- struct used for lexer -- */
typedef enum tk_class_en {
    // keywords 
    TK_INT = 1,
    TK_CHAR,
    TK_VOID,
    TK_RETURN,
    TK_CONST,
    // constant 
    TK_CONST_INT,
    TK_CONST_CHAR,
    TK_CONST_STRING,
    // operator / delimiter 
    TK_OP,
    #define xx(tk_class, u) tk_class,
    #define yy(tk_class, u) tk_class,
    #define zz(tk_class, u) 
    #include "operators.h"
    #undef xx
    #undef yy
    #undef zz
    TK_DELIMITER,
    // others 
    TK_IDENTIFIER
} tk_class_en;

typedef union value_un {
    int i;
    char c;
} value_un;

typedef struct token_st {
    enum tk_class_en tk_class;
    char *tk_str;
    value_un *value;
} token_st;
 
/* lex module (vars & funcs) */
token_st lex_token;
FILE    *lex_fp;
int lex_nextc;

int lex_load_file(const char *filename) {
    lex_fp = fopen(filename, "r");
    if(!lex_fp)
        fexit("Can't not open file %s", filename);
    
    return 0;
}

int lex_isspace(char c) {
    return c == ' ' || c == '\r' || c == '\n' || c == '\t';
}

int lex_peek() {
    if(lex_nextc == -1) {
        if(feof(lex_fp)) lex_nextc = -1;
        else lex_nextc = fgetc(lex_fp);
    }
    return lex_nextc;
}

int lex_getc() {
    int c = lex_peek();
    lex_nextc = -1;
    return c;
}

int lex_unget(int c) {
    if(lex_nextc != -1)
        ungetc(lex_nextc, lex_fp);
    lex_nextc = c;
    return 0;
}

int lex_next() {
    static char buf[1024];
    static value_un value;
    char *p = buf, c;
    
    lex_token.tk_str = NULL;
    lex_token.value  = NULL;
    lex_token.tk_class = 0;
    
    /* eat space */
    while((c = lex_peek()) != -1 && lex_isspace(c)) lex_getc();
    if(c == -1) return ELEX_FEOF;
    
    lex_token.tk_str = buf;
    
    /* eat comment */
    if(c == '/') {
        lex_getc(); c = lex_peek();
        if(c >= 0) {
            if(c == '/') {
                /* "//" comment */
                while((c = lex_getc()) != '\n') lex_getc();
            }
            else if(c == '*') {
                /* "/*" comment */
                int state = 0;
                while((c = lex_getc()) >= 0) {
                    if(state == 0 && c == '*') state = 1;
                    else if(state == 1) {
                        if(c == '*') state = 1;
                        else if (c == '/') break;
                        else state = 0;
                    }
                }
            }
            else lex_unget(c);
        }
    }
    
    if(lex_peek() == -1) return -1;
    
    /* 2 chars operators */
    buf[0] = lex_getc();
    if((c = lex_peek()) != -1) {
        buf[1] = c; buf[2] = 0;
        #define xx(u, v)
        #define zz(u, v)
        #define yy(tk_class_, tk_str_) \
            if(strcmp(buf, tk_str_) == 0) { \
                assert(lex_token.tk_class == 0); \
                lex_token.tk_class = tk_class_; \
            }
        #include "operators.h"
        #undef xx
        #undef yy
        #undef zz
        
        if(lex_token.tk_class) { 
            return 0;
        }
    }
    lex_unget(buf[0]);
    
    /* single char operators / delimiters */
    buf[0] = c = lex_peek(); buf[1] = 0;
    #define yy(u, v)
    #define zz xx
    #define xx(tk_class_, tk_char_) \
        if(c == tk_char_)  \
            lex_token.tk_class = tk_class_;
    #include "operators.h"
    #undef xx
    #undef yy
    #undef zz
    
    if(lex_token.tk_class) {
        lex_getc();
        return 0;
    }
    
    /* literal number */
    c = lex_peek();
    if( c >= '0' && c <= '9') {
        int v = 0;
        do {
            v = v * 10 + c - '0';
            *p++ = lex_getc();
            c = lex_peek();
        } while(c > 0 && c >= '0' && c <= '9');
        *p++ = 0;
        lex_token.tk_class = TK_CONST_INT;
        lex_token.value = &value;
        value.i = v;
        return 0;
    }
    
    /* literal string */
    
    /* identifier/keywords */
    c = lex_peek();
    do {
        *p++ = lex_getc();
        c = lex_peek();
    } while(c > 0 && 
           (c == '_' || 
             (c >= 'a' && c <= 'z') || 
             (c >= 'A' && c <= 'Z') ||
             (c >= '0' && c <= '9')));
    *p++ = 0;
    
    /* test keywords */
    #define xx(tk_class_, tk_str) \
            if(strcmp(buf, tk_str) == 0) { \
                assert(lex_token.tk_class == 0); \
                lex_token.tk_class = tk_class_; \
            }
    #include "keywords.h"
    #undef xx
    
    if(!lex_token.tk_class)
        lex_token.tk_class = TK_IDENTIFIER;
    
    return 0;
}

void lex_print_token(token_st *token) {
    int selected = 0;
    #define xx(tk_class_) \
        if(token->tk_class == tk_class_) { \
            assert(selected == 0); \
            selected = 1; \
            printf("(" #tk_class_ ", \"%s\"", token->tk_str); \
            if(token->tk_class == TK_CONST_INT) \
                printf(", %d)\n", token->value->i); \
            else \
                printf(")\n"); \
        }
    #include "lex_debug.h"
    #undef xx
    
    #define yy xx
    #define zz xx
    #define xx(tk_class_, u) \
        if(token->tk_class == tk_class_) { \
            assert(selected == 0); \
            selected = 1; \
            printf("(" #tk_class_ ", \"%s\")\n", token->tk_str); \
            return; \
        }
    #include "operators.h"
    #undef xx
    #undef yy
    #undef zz
}

void lex_init() {
    lex_nextc = -1;
    lex_fp = NULL;
}

void init(int argc, char **argv) {
    lex_init();
}

void test_lex(int argc, char **argv) {
    assert(argc == 2);
    lex_load_file(argv[1]);
    while(1) {
        int n = lex_next();
        if(n != 0) return;
        lex_print_token(&lex_token);
    }
}

int main(int argc, char **argv)
{
    init(argc, argv);
    test_lex(argc, argv);
}
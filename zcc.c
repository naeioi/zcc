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
int lex_isbinaryop(token_st*);
int lex_isunaryop(token_st*);

int prs_expect_char(char);
int prs_binary();
int prs_expr();
int prs_primary();
int prs_unary();
int prs_pst(int);

/* =---- utility ----= */
void fexit(const char *format, ...) {
    puts(format);
    printf("\n");
    exit(0);
}

/* =---- lex ----= */ 

/* -- structs used for lexer -- */
enum lex_ecode_en {
    ELEX_FILE_NULL = 1,
    ELEX_FEOF
};

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
    TK_OP_SIZEOF,
    #define xx(tk_class, u, v, w) tk_class,
    #define yy(tk_class, u, v, w) tk_class,
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

/***
 * one of || && | ^ & == != < > <= >= << >> + - * / %
 */
int lex_isbinaryop(token_st* tk) {
    return tk->tk_class >= BINARY_OP_START && tk->tk_class <= BINARY_OP_END;
}

/***
 * one of ++ -- & * + - - !
 */
int lex_isunaryop(token_st *tk) {
    return 
        tk->tk_class == TK_OP_INC   ||
        tk->tk_class == TK_OP_DEC   ||
        tk->tk_class == TK_OP_BAND  || 
        tk->tk_class == TK_OP_MUL   ||
        tk->tk_class == TK_OP_ADD   ||
        tk->tk_class == TK_OP_DEL   ||
        tk->tk_class == TK_OP_LNOT;
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
        #define xx(u, v, w, q)
        #define zz(u, v)
        #define yy(tk_class_, tk_str_, u, v) \
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
    #define zz(tk_class_, tk_char_) xx(tk_class_, tk_char_, 0, 0)
    #define xx(tk_class_, tk_char_, u, v) \
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

/* =---- Parser ----= */

/* Assumption: all tokens before lex_token are parsed. lex_token is the next to be parsed. */

int prs_prec[256];
int prs_asso[256];

void prs_init() {
    #define xx yy
    #define yy(tk_class, u, asso_, prec_) \
        prs_prec[tk_class] = prec_; \
        prs_asso[tk_class] = asso_;
    #include "operators.h"
    #undef xx
    #undef yy
}

int prs_expr() {
    prs_binary();
    return 0;
}

/***
 binary-expression:
    unary-expression { binary-operator unary-expression }
 
 Note: 
    prs_binary(k): parse binary expression of precedence k or higher
    precedence defined in operators.h
    trick avoiding deep recursion descripted in LCC Chap.8.6
*/

int prs_binary(int k) {
    int i;
    prs_unary();
    for(i = prec[lex_token.tk_class]; i >= k; i--) {
        /* parse from high precedence to low precedence */
        /* TODO: manage && || execution flow */
        while(prec[lex_token.tk_class] == i) {
            lex_next();
            prs_binary(i+1);
        }
    }
    return 0;
}

/***
 unary-expression:
    postfix-expression
    unary-operator unary-expression
    '(' type-name ')' unary-expression
    sizeof unary-expression
    sizeof '(' type-name ')'
*/

int prs_unary() {
    if(lex_token.tk_class == TK_OP_SIZEOF) {
        lex_next(); 
        if(lex_token.tk_str[0] == '(') {
            /* => sizeof '(' type-name ')' */
            lex_next();
            if(!sym_has(&lex_token))
                fexit("expect `type-name`.");
            else {
                lex_next();
                prs_expect_char(')'); lex_next();
            }
        }
        else 
            /* => sizeof unary-expression */
            prs_unary();
    }
    else if(lex_token.tk_str[0] == '(') {
        lex_next();
        if(sym_has(&lex_token)) {
            /* => '(' type-name ')' unary-expression */
            lex_next();
            prs_expect_char(')'); lex_next();
            prs_unary();
        }
        else {
            /* TRICK: parsed primary-expression for postfix-expression
             * => postfix-expression 
             * => primary-expression { postfix-operator }
             * => '(' expression ')' { postfix-operator }
             */
             prs_expr();
             prs_expect_char(')'); lex_next();
             prs_pst(1);
        }
    }
    else {
        /* => unary-operator unary-expression */
        lex_isunaryop(&lex_token);
        lex_next();
        prs_unary();
    }
    return 0;
}

/***
 postfix-expression:
    primary-expression { postfix-operator }
 postfix-operator:
    '[' expression ']'
    . identifier
    -> identifier
    ++
    -- 
    
 Note: assume primary-expression parsed by caller and passed(?) in.
*/

int prs_pst(int passed_primary/* placeholder for primary-expression */) {
    if(!passed_primary)
        prs_primary();
    while(1) {
        /* TODO: parse postfix-operator */
        if(lex_token.tk_str[0] == '[') {
            /* => '[' expression ']' */
            lex_next();
            prs_expr();
            prs_expect_char(']'); lex_next();
        }
        else if(lex_token.tk_str[0] == '.') {
            lex_next();
            sym_hasid(&lex_token);
            lex_next();
        }
        else if(lex_token.tk_class == TK_OP_DEREF) {
            lex_next();
            sym_hasid(&lex_token);
            lex_next();
        }
        else if(lex_token.tk_class == TK_OP_INC) {
            lex_next();
        }
        else if(lex_token.tk_class == TK_OP_DEC) {
            lex_next();
        }
        else break;
    }
    return 0;
}

/***
 primary-expression:
    identifer
    constant
    string-literal
    '(' expression ')'
*/

int prs_primary() {
    if(lex_token.tk_class == TK_IDENTIFIER) {
        lex_next();
    }
    else if(len_token.tk_class == TK_CONST_INT) {
        lex_next();
    }
    else if(len_token.tk_str[0] == '(') {
        lex_next();
        prs_expr();
        lex_next();
        prs_expect_char(')');
        lex_next();
    }
    else 
        fexit("Unexpected token");
    return 0;
}

/* =---- Others ----= */

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
/***
 * ZCC - a study purpose compiler for C programming language
 * By keren. naeioi@hotmail.com
 */

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

/* -- structs used for lexer -- */
enum lex_ecode_en {
    ELEX_FILE_NULL = 1,
    ELEX_FEOF
};

typedef enum tk_class_en {
    TK_PLACEHOLDER = 1,
    // keywords 
    #define xx(tk_class, u) tk_class,
    #include "keywords.h"
    #undef xx
    /* 
    TK_INT = 1,
    TK_CHAR,
    TK_VOID,
    TK_RETURN,
    TK_CONST,
    */
    // constant 
    TK_CONST_INT,
    TK_CONST_CHAR,
    TK_CONST_STRING,
    // operator / delimiter 
    TK_OP,
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
 
/* =-- forward declaration --= */
int lex_next();
int lex_getc();
int lex_isbinaryop(token_st*);
int lex_isunaryop(token_st*);
int lex_isassignop(token_st*);
int lex_valid();

int prs_expect_char(char);
int prs_expect_class(tk_class_en);
/* -- expr -- */
int prs_binary();
int prs_expr();
int prs_primary();
int prs_unary();
int prs_pst(int);
int prs_assign();
int prs_cond();
/* -- stmt -- */
int prs_stmt();
/* -- decl -- */
int prs_decls();


int sym_hasid(token_st*);
int sym_hastype(token_st*);
int sym_islabel(token_st*);

void fexit(const char *format, ...);
 
/* =---- utility ----= */
void fexit(const char *format, ...) {
    puts(format);
    printf("\n");
    exit(0);
}
 
/* =---- lex ----= */ 
 
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

int lex_valid() {
    return lex_token.tk_class > 0;
}

int lex_isspace(char c) {
    return c == ' ' || c == '\r' || c == '\n' || c == '\t';
}

/***
 * one of || && | ^ & == != < > <= >= << >> + - * / %
 */
int lex_isbinaryop(token_st* tk) {
    return tk->tk_class >= BINARY_OP_BEGIN && tk->tk_class <= BINARY_OP_END;
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

/***
 * one of = += -=  *=  /=  %=  <<= >>=  &=  ^=  |=
 * >>= <<= not currently supported.
 */
int lex_isassignop(token_st* tk) {
    return tk->tk_class >= ASSIGN_OP_BEGIN && tk->tk_class <= ASSIGN_OP_END;
        
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
            else lex_unget('/');
        }
    }
    
    /* eat space after comment */
    while((c = lex_peek()) != -1 && lex_isspace(c)) lex_getc();
    if(c == -1) return ELEX_FEOF;
    
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
            lex_getc();
            return 0;
        }
    }
    lex_unget(buf[0]);
    
    /* single char operators / delimiters */
    buf[0] = c = lex_peek(); buf[1] = 0;
    #define yy(u, v, x, y)
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
    #define zz(tk_class_, u) xx(tk_class_, u, 0, 0)
    #define xx(tk_class_, u, v, z) \
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

int _prs_depth = -1;
#define PRS_FUNC_BG _prs_depth++;
#define PRS_FUNC_ED _prs_depth--;
#define PT_PRT_IND \
    { int _i = _prs_depth; \
    while(_i--) fprintf(stderr, "- "); }
#define PT_FUNC \
    PT_PRT_IND \
    fprintf(stderr, "In %s()\n", __FUNCTION__);

int prs_prec[256];
int prs_asso[256];

/***
 * Initialize operator precedence & association 
 */
void prs_init() {
    #define zz(u, v)
    #define xx yy
    #define yy(tk_class, u, asso_, prec_) \
        prs_prec[tk_class] = prec_; \
        prs_asso[tk_class] = asso_;
    #include "operators.h"
    #undef xx
    #undef yy
    #undef zz
}

#define prs_expect_char(c) _prs_expect_char(c, __FUNCTION__, __LINE__)

int _prs_expect_char(char c, const char *fname, int linen) {
    if(lex_token.tk_str[0] != c) {
        fprintf(stderr, "\n=== In %s() line %d ===\n", fname, linen);
        fprintf(stderr, "Expect '%c' but encounter '%c'\n", c, lex_token.tk_str[0]);
    }
    assert(lex_token.tk_str[0] == c);
    return 0;
}

int prs_expect_class(tk_class_en tk_class) {
    assert(lex_token.tk_class == tk_class);
    return 0;
}

/* =-- Expressions --= */

/***
expression:
    assignment-expression { , assignment-expression }
*/
int prs_expr() {
    PRS_FUNC_BG
    PT_FUNC
    
    //prs_binary(prs_prec[TK_OP_ASSIGN]);
    prs_assign();
    while(lex_valid() && lex_token.tk_str[0] == ',') {
        PT_PRT_IND
        fprintf(stderr, "operator[,]\n");
        
        prs_assign();
    }
    
    PRS_FUNC_ED
    return 0;
}

/***
assignment-expression:
    conditional-expression
    unary-expression assign-operator assignment-expression
assign-operator:
    one of = += -=  *=  /=  %=  <<= >>=  &=  ^=  |=
    
Note:
    It's hard to choose from one of the productions. 
    So we merge them into 
    => conditional-expression assign-operator assignment-expression
    
    This leads to incorrect expresstion like a + b = c gets accepted
    But we could leave error detection later to semantic stage
*/
int prs_assign() {
    PRS_FUNC_BG
    PT_FUNC
    
    prs_cond();
    if(lex_valid() && lex_isassignop(&lex_token)) {
        PT_PRT_IND
        fprintf(stderr, "operator[%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_assign();
    }
    
    PRS_FUNC_ED
    return 0;
}

/***
conditional-expression:
    binary-expression [ ? expression : conditional-expression ]
*/

int prs_cond() {
    PRS_FUNC_BG
    PT_FUNC
    
    prs_binary(prs_prec[TK_OP_ASSIGN]+1);
    if(lex_valid() && lex_token.tk_str[0] == ':') {
        PT_PRT_IND
        fprintf(stderr, "operator[?:]\n");
        
        lex_next();
        prs_expr();
        prs_expect_char(':'); lex_next();
        prs_cond();
    }
    
    PRS_FUNC_ED
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
    PRS_FUNC_BG
    
    PT_PRT_IND
    fprintf(stderr, "In prs_binary(k=%d)\n", k);
    
    int i;
    prs_unary();
    for(i = prs_prec[lex_token.tk_class]; lex_valid() && i >= k; i--) {
        /* parse from high precedence to low precedence */
        /* TODO: 1. manage && || execution flow 
                 2. Possibly handle assignment
        */
        while(lex_valid() && prs_prec[lex_token.tk_class] == i) {
            
            PT_PRT_IND
            fprintf(stderr, "operator[%s]\n", lex_token.tk_str);
            
            lex_next();
            prs_binary(i+1);
        }
    }
    
    PRS_FUNC_ED
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
    PRS_FUNC_BG
    
    PT_FUNC
    
    if(lex_token.tk_class == TK_OP_SIZEOF) {
        lex_next(); 
        if(lex_token.tk_str[0] == '(') {
            /* => sizeof '(' type-name ')' */
            lex_next();
            if(!sym_hastype(&lex_token))
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
        if(sym_hastype(&lex_token)) {
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
    else if(lex_isunaryop(&lex_token)) {
        /* => unary-operator unary-expression */
        PT_PRT_IND
        fprintf(stderr, "operator[%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_unary();
    }
    else {
        prs_pst(0);
    }
    
    PRS_FUNC_ED
    return 0;
}

/***
 postfix-expression:
    primary-expression { postfix-operator }
 postfix-operator:
    '[' expression ']' // array index.   e.g. a[0]
    '(' expression ')' // function call. e.g. foo(0)
    . identifier
    -> identifier
    ++
    -- 
    
 Note: assume primary-expression parsed by caller and passed(?) in.
*/

int prs_pst(int passed_primary/* placeholder for primary-expression */) {
    PRS_FUNC_BG
    
    PT_FUNC
    
    if(!passed_primary)
        prs_primary();
    while(1) {
        /* TODO: parse postfix-operator */
        if(!lex_valid()) break;
        if(lex_token.tk_str[0] == '[') {
            /* => '[' expression ']' */
            lex_next();
            prs_expr();
            prs_expect_char(']'); lex_next();
        }
        else if(lex_token.tk_str[0] == '(') {
            lex_next();
            prs_expr();
            prs_expect_char(')'); lex_next();
        }
        else if(lex_token.tk_str[0] == '.') {
            PT_PRT_IND
            fprintf(stderr, "operator[.]\n");
            
            lex_next();
            sym_hasid(&lex_token);
            lex_next();
        }
        else if(lex_token.tk_class == TK_OP_DEREF) {
            PT_PRT_IND
            fprintf(stderr, "operator[->]\n");
            
            lex_next();
            sym_hasid(&lex_token);
            lex_next();
        }
        else if(lex_token.tk_class == TK_OP_INC) {
            PT_PRT_IND
            fprintf(stderr, "operator[T++]\n");
            
            lex_next();
        }
        else if(lex_token.tk_class == TK_OP_DEC) {
            PT_PRT_IND
            fprintf(stderr, "operator[T--]\n");
            
            lex_next();
        }
        else break;
    }
    
    PRS_FUNC_ED
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
    PRS_FUNC_BG

    if(lex_token.tk_class == TK_IDENTIFIER) {
        PT_PRT_IND
        printf("prs_primary[IDENTIFIER=%s]\n", lex_token.tk_str);
        lex_next();
    }
    else if(lex_token.tk_class == TK_CONST_INT) {
        PT_PRT_IND
        printf("prs_primary[CONST=%s]\n", lex_token.tk_str);
        lex_next();
    }
    else if(lex_token.tk_str[0] == '(') {
        lex_next();
        prs_expr();
        lex_next();
        prs_expect_char(')');
        lex_next();
    }
    else {
        PT_PRT_IND
        fexit("In primary(): Unexpected token");
    }
    
    PRS_FUNC_ED
    return 0;
}

/* =-- Statements --= */

/***
statement:
    ID : statement
    case constant-expression : statement
    default : statement
    [ expression ] ;
    if '(' expression ')' statement
    if '(' expression ')' statement else statement
    switch '(' expression ') ' statement
    while '(' expression ') ' statement
    do statement while '(' expression ')' ;
    for '(' [ expression ] ; [ expression ] ; [ expression ] ')' statement
    break ;
    continue ;
    goto ID ;
    return  [ expression ] ;
    compound-statement
compound-statement:
    '{' { declaration } { statement } '}'
    
Note:
    Seems like declaration is only allowed at the beginning of the block.
    This is subject to change but leave it for now.
*/

int prs_stmt() {
    PRS_FUNC_BG
    PT_FUNC
    
    if(sym_islabel(&lex_token)) {
        /* => ID : statement */
        PT_PRT_IND
        fprintf(stderr, "[label=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_char(':'); lex_next();
        prs_stmt();
    }
    else if(lex_token.tk_class == TK_CASE) {
        /* => case constant-expression : statement */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expr();
        prs_expect_char(':'); lex_next();
        prs_stmt();
    }
    else if(lex_token.tk_class == TK_DEFAULT) {
        /* => default : statement */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_char(':');
        prs_stmt();
    }
    else if(lex_token.tk_class == TK_IF) {
        /* => if '(' expression ')' statement
         * => if '(' expression ')' statement else statement
         */
         PT_PRT_IND
         fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
         
         lex_next();
         prs_expect_char('('); lex_next();
         prs_expr();
         prs_expect_char(')'); lex_next();
         
         prs_stmt();
         if(lex_valid() && lex_token.tk_class == TK_ELSE) {
            PT_PRT_IND
            fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
            
            lex_next();
            prs_stmt();
         }
    }
    else if(lex_token.tk_class == TK_SWITCH) {
        /* => switch '(' expression ') ' statement */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_char('('); lex_next();
        prs_expr();
        prs_expect_char(')'); lex_next();
        
        prs_stmt();
    }
    else if(lex_token.tk_class == TK_WHILE) {
        /* => while '(' expression ') ' statement */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_char('('); lex_next();
        prs_expr();
        prs_expect_char(')'); lex_next();
        
        prs_stmt();
    }
    else if(lex_token.tk_class == TK_DO) {
        /* => do statement while '(' expression ')'; */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_stmt();
        prs_expect_class(TK_WHILE); lex_next();
        prs_expect_char('('); lex_next();
        prs_expr();
        prs_expect_char(')'); lex_next();
        prs_expect_char(';'); lex_next();
    }
    else if(lex_token.tk_class == TK_FOR) {
        /* => for '(' [ expression ] ; [ expression ] ; [ expression ] ')' statement */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_char('('); lex_next();
        if(lex_token.tk_str[0] != ';') {
            prs_expr();
        }
        prs_expect_char(';'); lex_next();
        if(lex_token.tk_str[0] != ';') {
            prs_expr();
        }
        prs_expect_char(';'); lex_next();
        if(lex_token.tk_str[0] != ')') {
            prs_expr();
        }
        prs_expect_char(')'); lex_next();
        
        prs_stmt();
    }
    else if(lex_token.tk_class == TK_BREAK) {
        /* => break ; */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_char(';'); lex_next();
    }
    else if(lex_token.tk_class == TK_CONTINUE) {
        /* => continue ; */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_char(';'); lex_next();
    }
    else if(lex_token.tk_class == TK_GOTO) {
        /* => break ; */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        prs_expect_class(TK_IDENTIFIER); lex_next();
        prs_expect_char(';'); lex_next();
    }
    else if(lex_token.tk_class == TK_RETURN) {
        /* => return  [ expression ] ; */
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        
        lex_next();
        if(lex_token.tk_str[0] != ';') {
            prs_expr();
        }
        prs_expect_char(';'); lex_next();
    }
    else if(lex_token.tk_str[0] == '{') {
        /* => '{' { declaration } { statement } '}' */
        /* TODO: need declaration */
        PT_PRT_IND
        fprintf(stderr, "stmt[{}]\n");
        
        lex_next();
        
        prs_decls();
        while(lex_token.tk_str[0] != '}') {
            prs_stmt();
        }
        
        prs_expect_char('}'); lex_next(); 
        
        PT_PRT_IND
        fprintf(stderr, "prs_stmt[leave]\n");
    }
    else if(lex_token.tk_str[0] != '}') {
        /* => [expression] ;
         * (single expression)
         */
        prs_expr();
        prs_expect_char(';'); lex_next(); 
    }
    
    PRS_FUNC_ED;
    return 0;
}

/* =-- Statements --= */

/***
 * { declaration }
 */
int prs_decls() {
    /* TODO: forbid nested function declaration */
    while(sym_hastype(&lex_token)) {
        prs_decl();
    }
    return 0;
}

/***
declaration:
    declaration-specifiers init-declarator { , init-declarator } ;
    declaration-specifiers func-declarator compound-statement
    
init-declarator:
    identifier
    identifier = assignment-expression
    
func-declarator:
    identifer '(' parameter-list ')'
    
parameter-list:
    parameter { , parameter } [ , ... ]

parameter:
    declaration-specifiers identifier
*/
int prs_decl() {
    /* declaration-specifiers => 
     *   int
     *   int*
     */
     
    PRS_FUNC_BG
    PT_FUNC 
     
    if(lex_token.tk_class == TK_INT) {
        lex_next();
        
        PT_PRT_IND;
        if(lex_token.tk_str[0] == '*') {
            lex_next();
            fprintf(stderr, "type[int*]\n");
        }
        else {
            fprintf(stderr, "type[int]\n");
        }
    }
    
    /* => init-declarator { , init-declarator } ; 
     * => identifier { ... }
     *    identifier = assignment-expression  { ... }
     */
    
    do {
        prs_expect_class(TK_IDENTIFIER); 
        
        PT_PRT_IND
        fprintf(stderr, "%s[name='%s']\n", lex_token.tk_str[0] == '(' ? "func" : "var", lex_token.tk_str);
        
        lex_next();
        if(lex_token.tk_class == TK_ASSIGN) {
            PT_PRT_IND
            fprintf(stderr, "operator[=]\n");
            lex_next();
            
            prs_assign();
        }
    } while(lex_token.tk_str[0] == ',');
    
    if(lex_token.tk_str[0] == '(') {
        /* => declaration-specifiers func-declarator compound-statement
         * => declaration-specifiers identifer '(' parameter-list ')'
         * where specifier & identifier are already parsed
         *
         * parameter-list: parameter { , parameter } [ , ... ]
         * parameter: declaration-specifiers identifier
         */
         lex_next();
         
         do {
             prs_decl_spec();
             
             prs_expect_class(TK_IDENTIFIER); 
             PT_PRT_IND
             fprintf(stderr, "para[name='%s']\n", lex_token.tk_str);
             lex_next();
         } while(lex_token.tk_str[0] == ',');
         
         prs_expect_char(')'); lex_next();
         prs_expect_char('{'); lex_next();
         
         prs_stmt();
    }
    else 
        prs_expect_char(';'); lex_next();
    
    PRS_FUNC_ED
    return 0;
}

/* =---- Symbol manager ----= */

int sym_hasid(token_st *tk) {
    /* TODO */
    return 1;
}

int sym_hastype(token_st *tk) {
    /* TODO */
    return 0;
}

int sym_islabel(token_st* tk) {
    /* TODO */
    return 0;
}

/* =---- Others ----= */

void init(int argc, char **argv) {
    lex_init();
}

void test_lex(const char *filename) {
    lex_load_file(filename);
    while(1) {
        int n = lex_next();
        if(n != 0) return;
        lex_print_token(&lex_token);
    }
}

void test_binary(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    prs_expr();
}

void test_stmt(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    prs_stmt();
}

int main(int argc, char **argv)
{
    init(argc, argv);
    if(argc == 3 && strcmp("-l", argv[1]) == 0)
        test_lex(argv[2]);
    if(argc == 3 && strcmp("-b", argv[1]) == 0)
        test_binary(argv[2]);
    if(argc == 3 && strcmp("-s", argv[1]) == 0)
        test_stmt(argv[2]);
}   
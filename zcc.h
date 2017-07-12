/* zcc.h */

/* -- Runtime managerment -- */

struct list_st;
struct type_st;
struct context_st;
struct func_st;
struct var_st;
union value_un;

typedef struct type_st {
    int bytes;
    int native;     /* is native type */
    type_st* ref;   /* ref != NULL if its pointer */
    char *name;     /* name == NULL for pointer */
} type_st;

typedef struct func_st {
    char    *name;
    type_st *rtype;
    list_st *pars;
    list_st *insts;
    var_st  *ret;
    int     lvalue;
} func_st;

typedef struct list_st {
    void **elems;
    int len;
    int room; /* reservered size */
} list_st;

typedef struct var_st {
    char     *name;
    type_st  *type;
    value_un *value;
    int      ispar; /* 0 if not parameter. otherwise parameter index. (i.e. ispar=1 for the first parameter) */
} var_st;

typedef struct scope_st {
    struct scope_st *up;
    list_st *vars;
} scope_st;

typedef struct label_st {
    func_st *func;
    int ind;
}

typedef struct context_st {
    scope_st *scope;
    func_st  *func;
    list_st  *types; /* in C, types are global */
} context_st;

typedef enum ir_op_en {
    IR_ADD,
    IR_SUB,
    IR_MUL,
    IR_DIV
} ir_op_en;

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
 
/* public variables */
extern token_st   lex_token;
extern context_st context; 
extern type_st    *type_int;
 
/* =-- forward declaration --= */
int lex_load_file(const char *);
void lex_print_token(token_st *);
void lex_init();
int lex_next();
int lex_getc();
int lex_isbinaryop(token_st*);
int lex_isunaryop(token_st*);
int lex_isassignop(token_st*);
int lex_valid();

void prs_init();
int prs_expect_char(char);
int prs_expect_class(tk_class_en);
/* -- expr -- */
int prs_binary();
int prs_expr();
int prs_primary();
list_st* prs_args();
int prs_unary();
int prs_pst(int);
int prs_assign();
int prs_cond();
/* -- stmt -- */
int prs_stmt();
/* -- decl -- */
int prs_decls();
int prs_decl();
int prs_decl_spec();

int sym_hasid(token_st*);
int sym_hastype(token_st*);
int sym_islabel(token_st*);
scope_st*   sym_make_scope();
scope_st*   sym_mnp_scope(); /* make and push scope to context */
void   sym_push_scope(scope_st*);
void   sym_pop_scope();
var_st*     sym_make_var(char*, type_st*);
var_st*     sym_make_temp_var(type_st*);
var_st*     sym_make_imm(lex_token*);
var_st*     sym_make_par(char*, type_st*);
func_st*    sym_make_func(char*, type_st*);
void        sym_add_type(type_st*);

void fexit(const char *format, ...);
char* dup_str(char*);
list_st* make_list();
void*    list_append(list_st*, void*);

/*==-- Macros --==*/
#define EMIT_M_MACRO(_0,_1,_2, _3, NAME, ...) NAME
#define gen_emit(...) EMIT_M_MACRO(__VA_ARGS__, gen_emit3, gen_emit2, gen_emit1, gen_emit0)(__VA_ARGS__)
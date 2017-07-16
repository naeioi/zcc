/* zcc.h */
#include <stdio.h>

struct list_st;
struct type_st;
struct context_st;
struct func_st;
struct var_st;
union  value_un;
struct token_st;
enum ir_op_en;

/* structs */

typedef struct type_st {
    int bytes;
    int native;     /* is native type */
    struct type_st* ref;   /* ref != NULL if its pointer */
    char *name;     /* name == NULL for pointer */
} type_st;

typedef struct func_st {
    char    *name;
    struct type_st *rtype;
    struct list_st *pars; /* list of var_st */
    struct list_st *insts;
    struct var_st  *ret;
    int declared;
    int defined;
    /* for gen */
    int rbytes; /* bytes should reserved for local variables */
} func_st;

typedef struct list_st {
    void **elems;
    int len;
    int room; /* reservered size */
} list_st;

typedef struct var_st {
    char     *name;
    struct type_st  *type;
    union value_un *value;
    int      ispar; /* 0 if not parameter. otherwise parameter index. (i.e. ispar=1 for the first parameter) */
    int      lvalue;
    
    /* for ir & gen */
    char *irname;
    #define STACK_VAR 0
    #define HEAP_VAR  1
    int where; 
    /* ref == 1 indicates this var is a lvalue and is indirectly access. 
     * i.e. the address of var but not var itself is store on stack or heap
     */
    int ref; 
    /* var address for stack_var. 
     * access by -(addr+8)(%rbp)
     * heap_var is access by name(%rip)
     */
    int addr;
} var_st;

typedef struct scope_st {
    struct scope_st *up;
    struct list_st *vars; /* list of var_st* */
    struct label_st *forC; /* condition */
    struct label_st *forB; /* body */
    struct label_st *forE;
} scope_st;

typedef struct label_st {
    struct func_st *func;
    struct label_st *chain; /* shared label. */
    char *irname;
} label_st;

typedef struct context_st {
    struct scope_st *scope;
    struct func_st  *func;
    struct list_st  *funcs; /* list of func_st* */
    struct list_st  *types; /* list of type_st*. in C, types are global */
    struct list_st  *cstr;  /* list of var_st*, const string */
} context_st;

typedef enum ir_op_en {
    IR_ADD = 0,     /* (var, var, var) */
    IR_SUB,     /* ... */
    IR_MUL,     /* ... */
    IR_DIV,     /* ... */
    IR_RETURN,  /* (var) */
    IR_CALL,    /* (var, func, list<var>) */
    IR_ASSIGN,  /* (var, var) */
    IR_LABEL,   /* (label)  */
    IR_JMP,     /* (label)  */
    IR_CJMP,    /* (var, label) */
    IR_LT,      /* (var, var, var) */
    IR_LE,      /* ... */
    IR_EQ,      /* ... */
    IR_GT,      /* ... */
    IR_GE,      /* ... */
    IR_NEQ,     /* ... */
    IR_INC,     /* (var) */
    IR_DEC,     /* ... */
    IR_IND      /* (var, var, var) */
} ir_op_en;

typedef struct inst_st {
    ir_op_en op;
    void* args[3]; /* maximum 3 args */
} inst_st;

/* -- structs used for lexer -- */
enum lex_ecode_en {
    ELEX_FILE_NULL = 1,
    ELEX_FEOF
};

typedef enum tk_class_en {
    TK_NO_CLASS = 0,
    // keywords 
    #define xx(tk_class, u) tk_class,
    #include "keywords.h"
    #undef xx
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
    char *s;
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
extern type_st    *type_int_ptr;
extern type_st    *type_char;
extern type_st    *type_char_ptr;
extern func_st    *wrap_func; 
 
/* =-- forward declaration --= */

/* == lex == */
int lex_load_file(const char *);
void lex_print_token(token_st *);
void lex_init();
int lex_next();
int lex_getc();
int lex_isbinaryop(token_st*);
int lex_isunaryop(token_st*);
int lex_isassignop(token_st*);
int lex_valid();

/* == parse == */
void prs_init();
int prs_expect_char(char);
int prs_expect_class(tk_class_en);
/* -- expr -- */
var_st* prs_binary();
var_st* prs_expr();
var_st* prs_primary();
list_st* prs_args();
var_st* prs_unary();
var_st* prs_pst(var_st*);
var_st* prs_assign();
var_st* prs_cond();
/* -- stmt -- */
int prs_stmt_return();
int prs_stmt_if();
int prs_stmt_else();
int prs_stmt_for();
int prs_stmt_while();
int prs_stmt_dowhile();
int prs_stmt_switch();
int prs_stmt_break();
int prs_stmt_continue();
int prs_stmt();
/* -- decl -- */
int prs_decls();
int prs_decl();
type_st* prs_decl_spec();

/* == sym == */
int sym_init();
int sym_hasid(token_st*);
int sym_hastype(token_st*);
int sym_islabel(token_st*);
int sym_is_pointer(var_st*);
scope_st*   sym_make_scope();
scope_st*   sym_mnp_scope(); /* make and push scope to context */
void   sym_push_scope(scope_st*);
void   sym_pop_scope();
int         sym_redefined_var(char*);
var_st*     sym_make_var(char*, type_st*);
var_st*     sym_find_var(char*);
var_st*     sym_add_var(var_st*);
var_st*     sym_make_temp_var(type_st*);
var_st*     sym_make_temp_lvar(type_st*, int);
void        sym_dispose_temp_var(var_st*);
var_st*     sym_make_imm(token_st*);
var_st*     sym_make_par(char*, type_st*);
func_st*    sym_make_func(char*, type_st*);
int         sym_is_full_pars(func_st*);
func_st*    sym_make_temp_func(char*, type_st*);
func_st*    sym_find_func(char*);
void        sym_add_type(type_st*);
label_st*   sym_make_label();
type_st*    pointer_of(type_st*);

/* == gen == */
void gen_emit0(ir_op_en);
void gen_emit1(ir_op_en, void*);
void gen_emit2(ir_op_en, void*, void*);
void gen_emit3(ir_op_en, void*, void*, void*);
void gen_emit_call(ir_op_en, func_st*, var_st*, list_st*);
void gen_print_func_ir(func_st*);

/* target-specific gen 
 * link gen-x.c to support different target
 */
void gen_assembly(FILE*);

/* util */
void fexit(const char *format, ...);
char* dup_str(char*);
var_st*   dup_arg(ir_op_en, int, var_st*);
var_st*   dup_temp_var(var_st*);
value_un* dup_value(token_st*);
list_st* make_list();
void*   list_append(list_st*, void*);
void*   list_pop(list_st*);
int     list_isempty(list_st*);
int     list_index(list_st*, void*);

/*==-- Macros --==*/
#define EMIT_M_MACRO(_0,_1,_2, _3, NAME, ...) NAME
#define gen_emit(...) EMIT_M_MACRO(__VA_ARGS__, gen_emit3, gen_emit2, gen_emit1, gen_emit0)(__VA_ARGS__)

#define DEMINER fprintf(stderr, "Run upon Line %d\n", __LINE__);
/* parse.c */
#include "zcc.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

/* =---- Parser ----= */

/* Assumption: all tokens before lex_token are parsed. lex_token is the next to be parsed. */

int _prs_depth = -1;
//#define PRT_LEAVING
#define PRS_FUNC_BG _prs_depth++;
#ifdef PRT_LEAVING
#define PRS_FUNC_ED \
    PT_PRT_IND\
    fprintf(stderr, "%s() leaving\n", __FUNCTION__); \
    _prs_depth--;
#else
#define PRS_FUNC_ED _prs_depth--;    
#endif
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

#define prs_expect_char(c)  _prs_expect_char (c, __FUNCTION__, __LINE__)
#define prs_expect_class(c) _prs_expect_class(c, #c, __FUNCTION__, __LINE__)

int _prs_expect_char(char c, const char *fname, int linen) {
    if(lex_token.tk_str[0] != c) {
        fprintf(stderr, "\n=== In %s() line %d ===\n", fname, linen);
        fprintf(stderr, "Expect '%c' but encounter '%c'\n", c, lex_token.tk_str[0]);
    }
    assert(lex_token.tk_str[0] == c);
    return 0;
}

int _prs_expect_class(tk_class_en tk_class, const char *cname, const char *fname, int linen) {
    if(lex_token.tk_class != tk_class) {
        fprintf(stderr, "\n=== In %s() line %d ===\n", fname, linen);
        fprintf(stderr, "Expect '%s' but encounter '%s'\n", cname, lex_token.tk_str);
    }
    assert(lex_token.tk_class == tk_class);
    return 0;
}

/* =-- Expressions --= */

/***
expression:
    assignment-expression { , assignment-expression }
*/
var_st* prs_expr() {
    PRS_FUNC_BG
    PT_FUNC
    
    var_st *r;
    
    //prs_binary(prs_prec[TK_OP_ASSIGN]);
    r = prs_assign();
    while(lex_valid() && lex_token.tk_str[0] == ',') {
        PT_PRT_IND
        fprintf(stderr, "operator[,]\n");
        lex_next();
        
        r = prs_assign();
    }
    
    PRS_FUNC_ED
    
    return r;
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
    i.e. reject input once we find a+b is not lvalue.
*/
var_st* prs_assign() {
    PRS_FUNC_BG
    PT_FUNC
    
    var_st *r, *t;
    
    r = prs_cond();
    if(lex_valid() && lex_isassignop(&lex_token)) {
        PT_PRT_IND
        fprintf(stderr, "operator[%s]\n", lex_token.tk_str);
        
        /* TODO: support assignment other than = */
        lex_next();
        t = prs_assign();
        assert(r->lvalue == 1);
        gen_emit(IR_ASSIGN, r, t);
        sym_dispose_temp_var(t);
    }
    
    PRS_FUNC_ED
    return r;
}

/***
conditional-expression:
    binary-expression [ ? expression : conditional-expression ]
*/

var_st* prs_cond() {
    PRS_FUNC_BG
    PT_FUNC
    
    var_st *r;
    
    r = prs_binary(prs_prec[TK_OP_ASSIGN]+1);
    if(lex_valid() && lex_token.tk_str[0] == '?') {
        PT_PRT_IND
        fprintf(stderr, "operator[?:]\n");
        
        /* TODO: support trinity operator, i.e. cond ? A : B; */
        
        lex_next();
        prs_expr();
        prs_expect_char(':'); lex_next();
        prs_cond();
    }
    
    PRS_FUNC_ED
    return r;
}

/***
 binary-expression:
    unary-expression { binary-operator unary-expression }
 
 Note: 
    prs_binary(k): parse binary expression of precedence k or higher
    precedence defined in operators.h
    trick avoiding deep recursion descripted in LCC Chap.8.6
*/

var_st* prs_binary(int k) {
    PRS_FUNC_BG
    
    PT_PRT_IND
    fprintf(stderr, "In prs_binary(k=%d)\n", k);
    
    var_st *r, *u = NULL, *x, *y, *t = sym_make_temp_var(type_int);
    ir_op_en    ir_op;
    tk_class_en tk_op;
    
    int i;
    r = prs_unary();
    for(i = prs_prec[lex_token.tk_class]; lex_valid() && i >= k; i--) {
        /* parse from high precedence to low precedence */
        /* TODO: 1. manage && || execution flow 
                 2. add support to other operators
                 3. support for pointer add integer, pointers subtract
                 4. support other operators
                 5. variable lifting (a.k.a varible promition)
        */
        while(lex_valid() && prs_prec[lex_token.tk_class] == i) {
            
            PT_PRT_IND
            fprintf(stderr, "operator[%s]\n", lex_token.tk_str);
            
            tk_op = lex_token.tk_class;
            if(tk_op == TK_OP_ADD) ir_op = IR_ADD;
            else if(tk_op == TK_OP_LT) ir_op = IR_LT;
            else if(tk_op == TK_OP_LE) ir_op = IR_LE;
            else if(tk_op == TK_OP_EQ) ir_op = IR_EQ;
            else if(tk_op == TK_OP_GT) ir_op = IR_GT;
            else if(tk_op == TK_OP_GE) ir_op = IR_GE;
            else if(tk_op == TK_OP_NEQ) ir_op = IR_NEQ;
            else if(tk_op == TK_OP_SUB) ir_op = IR_SUB;
            else if(tk_op == TK_OP_MUL) ir_op = IR_MUL;
            else if(tk_op == TK_OP_DIV) ir_op = IR_DIV;
            else fexit("Not supported operator %s", lex_token.tk_str);
            
            lex_next();
            y = prs_binary(i+1);
            
            if(u == NULL) {
                /* TODO: variable lifting */
                x = r;
                u = sym_make_temp_var(binop_res_type(ir_op, x->type, y->type));
            }
            else {
                x = u;
                u->type = binop_res_type(ir_op, x->type, y->type);
            }
            
            if(sym_is_pointer(x) || sym_is_pointer(y)) {
                if(x->type == type_int) {
                    gen_emit_offset(t, x, y->type->ref->bytes);
                    x = y; y = t;
                }
                if(y->type == type_int) {
                    gen_emit_offset(t, y, x->type->ref->bytes);
                    y = t;
                }
            }
            
            gen_emit(ir_op, u, x, y);
        }
    }
    
    sym_dispose_temp_var(t);
    
    PRS_FUNC_ED
    return u ? u : r;
}

/***
 unary-expression:
    postfix-expression
    unary-operator unary-expression
    '(' type-name ')' unary-expression
    sizeof unary-expression
    sizeof '(' type-name ')'
*/

var_st* prs_unary() {
    PRS_FUNC_BG
    PT_FUNC
    
    var_st *r = NULL;
    
    if(lex_token.tk_class == TK_OP_SIZEOF) {
        /* TODO */
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
        /* TODO */
        lex_next();
        if(sym_hastype(&lex_token)) {
            /* => '(' type-name ')' unary-expression */
            lex_next();
            prs_expect_char(')'); lex_next();
            prs_unary(); /* TODO */
        }
        else {
            /* TRICK: parsed primary-expression for postfix-expression
             * => postfix-expression 
             * => primary-expression { postfix-operator }
             * => '(' expression ')' { postfix-operator }
             */
             var_st *var = prs_expr();
             prs_expect_char(')'); lex_next();
             r = prs_pst(var);
        }
    }
    else if(lex_isunaryop(&lex_token)) {
        /* TODO */
        /* => unary-operator unary-expression */
        tk_class_en tk_class = lex_token.tk_class;
        
        PT_PRT_IND
        fprintf(stderr, "operator[%s]\n", lex_token.tk_str);
        lex_next();
        
        if(tk_class == TK_OP_MUL) {
            r = prs_unary();
            assert(sym_is_pointer(r));
            r = sym_deref(r);
        }
        else {
            /* TODO */
            fexit("unary operator other than * not implemented");
        }
    }
    else {
        r = prs_pst(0);
    }
    
    PRS_FUNC_ED
    return r;
}

/***
 postfix-expression:
    primary-expression { postfix-operator }
 postfix-operator:
    '[' expression ']' // array index.   e.g. a[0]
    . identifier
    -> identifier
    ++
    -- 
    
 Note: assume primary-expression parsed by caller and passed(?) in.
*/

var_st* prs_pst(var_st* passed_primary/* placeholder for primary-expression */) {
    PRS_FUNC_BG
    PT_FUNC
    
    var_st *r = passed_primary, *t, *ind;
    
    if(!passed_primary)
        r = prs_primary();
    while(1) {
        /* TODO: parse postfix-operator */
        if(!lex_valid()) break;
        if(lex_token.tk_str[0] == '[') {
            /* => '[' expression ']' */
            lex_next();
            ind = prs_expr();
            assert(sym_is_pointer(r));
            t = sym_make_temp_lvar(r->type->ref, 1); /* make lvalue */
            gen_emit(IR_IND, t, r, ind);
            sym_dispose_temp_var(r);
            r = t;
            prs_expect_char(']'); lex_next();
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
            
            t = sym_make_temp_var(r->type);
            gen_emit(IR_ASSIGN, t, r);
            gen_emit(IR_INC, r);
            r = t;
        }
        else if(lex_token.tk_class == TK_OP_DEC) {
            PT_PRT_IND
            fprintf(stderr, "operator[T--]\n");
            lex_next();
            
            t = sym_make_temp_var(r->type);
            gen_emit(IR_ASSIGN, t, r);
            gen_emit(IR_DEC, r);
            r = t;
        }
        else break;
    }
    
    PRS_FUNC_ED
    
    return r;
}

/***
 primary-expression:
    identifer
    constant
    string-literal
    '(' expression ')'
    function-call

function-call:
    identifier '(' argument-list ')'
*/

var_st* prs_primary() {
    PRS_FUNC_BG
    
    char vname[56];
    var_st* r = NULL;
    
    if(lex_token.tk_class == TK_IDENTIFIER) {
        PT_PRT_IND
        printf("prs_primary[IDENTIFIER=%s]\n", lex_token.tk_str);
        
        strcpy(vname, lex_token.tk_str);
        lex_next();
        
        if(lex_token.tk_str[0] != '(') {
            /* => identifer */
            fprintf(stderr, "finding var[%s]\n", vname);
            r = sym_find_var(vname);
            //assert(r);
            if(!r) {
                fprintf(stderr, "var[name=%s] not found\n", vname);
                fexit("");
            }
        }
        else {
            /* => function-call */
            lex_next();
            PT_PRT_IND
            printf("prs_primary[call=%s()]\n", vname);
            
            list_st *pars = prs_args();
            func_st *func = sym_find_func(vname);
            if(!func) {
                fprintf(stderr, "Warning: function call of var[name=%s] not declared\n", vname);
                /* TODO: 
                 * for now, regard undeclared function return int.
                 */
                func = sym_make_temp_func(vname, type_int);
            }
            r = sym_make_temp_var(func->rtype);
            gen_emit_call(IR_CALL, func, r, pars);
            prs_expect_char(')'); lex_next();
        }
    }
    else if(lex_token.tk_class == TK_CONST_INT) {
        PT_PRT_IND
        printf("prs_primary[CONST=%s]\n", lex_token.tk_str);
        r = sym_make_imm(&lex_token);
        //fprintf(stderr, "const[addr=%x, value=%d]", r, r->value->i);
        lex_next();
        //fprintf(stderr, "!--sym_make_imm(&lex_token)\n");
    }
    else if(lex_token.tk_class == TK_CONST_STRING) {
        PT_PRT_IND
        r = sym_make_imm(&lex_token);
        lex_next();
    }
    else if(lex_token.tk_str[0] == '(') {
        lex_next();
        r = prs_expr();
        lex_next();
        prs_expect_char(')');
        lex_next();
    }
    else {
        PT_PRT_IND
        fprintf(stderr, "In primary(): token[%s]\n", lex_token.tk_str);
        PT_PRT_IND
        fexit("In primary(): Unexpected token");
    }
    
    PRS_FUNC_ED
    return r;
}

/***
argument-list:
    assignment-expression { , assignment-expression }
*/
list_st* prs_args() {
    PRS_FUNC_BG
    PT_FUNC
    
    list_st *args = make_list();
    if(lex_token.tk_str[0] == ')') return args;
    
    int i = 0;
    while(1) {
        i++;
        list_append(args, prs_assign());
        if(lex_token.tk_str[0] == ',') lex_next();
        else if(lex_token.tk_str[0] == ')') break;
        else fexit("Unexpected token");
    }
    
    PRS_FUNC_ED
    return args;
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

int prs_stmt_label() {
     /* => ID : statement */
    PT_PRT_IND
    fprintf(stderr, "[label=%s]\n", lex_token.tk_str);
    
    lex_next();
    prs_expect_char(':'); lex_next();
    prs_stmt();
    
    return 0;
}

int prs_stmt_case() {
    /* => case constant-expression : statement */
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    lex_next();
    prs_expr();
    prs_expect_char(':'); lex_next();
    prs_stmt();
    
    return 0;
}

int prs_stmt_default() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    lex_next();
    prs_expect_char(':');
    prs_stmt();
    
    return 0;
}

int prs_stmt_if() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);

    var_st *cond;
    label_st *ifT = sym_make_label(), *ifF = sym_make_label(), *ifE = sym_make_label();
    
    lex_next();
    prs_expect_char('('); lex_next();
    cond = prs_expr();
    prs_expect_char(')'); lex_next();
    
    if(cond->value) {
        if(cond->value->i) gen_emit(IR_JMP, ifT);
        else gen_emit(IR_JMP, ifF);
    }
    else {
        gen_emit(IR_CJMP, cond, ifT);
        gen_emit(IR_JMP, ifF);
    }
    
    sym_dispose_temp_var(cond);
    gen_emit(IR_LABEL, ifT);
    prs_stmt();
    gen_emit(IR_JMP, ifE);
    if(lex_valid() && lex_token.tk_class == TK_ELSE) {
        PT_PRT_IND
        fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
        lex_next();
        
        gen_emit(IR_LABEL, ifF);
        prs_stmt();
    }
    else ifF->chain = ifE;
    
    gen_emit(IR_LABEL, ifE);
    
    return 0;
}

int prs_stmt_switch() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);

    lex_next();
    prs_expect_char('('); lex_next();
    prs_expr();
    prs_expect_char(')'); lex_next();

    prs_stmt();
    
    return 0;
}

int prs_stmt_while() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    sym_mnp_scope();
    
    var_st *cond;
    label_st *forC = sym_make_label(), *forB = sym_make_label(), *forE = sym_make_label();
    context.scope->forB = forB; 
    context.scope->forE = forE; 
    context.scope->forC = forC;
    
    gen_emit(IR_LABEL, forC);
    lex_next();
    prs_expect_char('('); lex_next();
    cond = prs_expr();
    prs_expect_char(')'); lex_next();
    
    if(cond->value) {
        /* deterministic branch */
        if(cond->value->i) gen_emit(IR_JMP, forB);
        else gen_emit(IR_JMP, forE);
    }
    else {
        gen_emit(IR_CJMP, cond, forB);
        gen_emit(IR_JMP, forE);
    }
    sym_dispose_temp_var(cond);
    gen_emit(IR_LABEL, forB);
    prs_stmt();
    gen_emit(IR_LABEL, forE);
    
    sym_pop_scope();
    return 0;
}

int prs_stmt_dowhile() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);

    sym_mnp_scope();
    
    var_st *cond;
    label_st *forB = sym_make_label(), *forE = sym_make_label();
    context.scope->forB = forB; 
    context.scope->forE = forE; 
    
    gen_emit(IR_LABEL, forB);
    lex_next();
    prs_stmt();
    prs_expect_class(TK_WHILE); lex_next();
    prs_expect_char('('); lex_next();
    cond = prs_expr();
    gen_emit(IR_CJMP, cond, forB);
    sym_dispose_temp_var(cond);
    prs_expect_char(')'); lex_next();
    prs_expect_char(';'); lex_next();
    gen_emit(IR_LABEL, forE);
    
    sym_pop_scope();
    return 0;
}

int prs_stmt_for() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    sym_mnp_scope();
    
    var_st *cond;
    label_st *forB = sym_make_label(), *forC = sym_make_label(), *forE = sym_make_label();
    label_st *forI = sym_make_label();
    context.scope->forB = forB; 
    context.scope->forE = forE; 
    context.scope->forC = forC;
    
    lex_next();
    prs_expect_char('('); lex_next();
    if(lex_token.tk_str[0] != ';') {
        prs_expr();
    }
    prs_expect_char(';'); lex_next();
    if(lex_token.tk_str[0] != ';') {
        gen_emit(IR_LABEL, forC);
        cond = prs_expr();
        gen_emit(IR_CJMP, cond, forB);
        gen_emit(IR_JMP, forE);
    }
    prs_expect_char(';'); lex_next();
    if(lex_token.tk_str[0] != ')') {
        gen_emit(IR_LABEL, forI);
        prs_expr();
        gen_emit(IR_JMP, forC);
    }
    prs_expect_char(')'); lex_next();
    sym_dispose_temp_var(cond);
    gen_emit(IR_LABEL, forB);
    prs_stmt();
    gen_emit(IR_JMP, forI);
    gen_emit(IR_LABEL, forE);
    
    sym_pop_scope();
    return 0;
}

int prs_stmt_break() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    lex_next();
    prs_expect_char(';'); lex_next();
    
    assert(context.scope->forE);
    gen_emit(IR_JMP, context.scope->forE);
    
    return 0;
}

int prs_stmt_continue() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    lex_next();
    prs_expect_char(';'); lex_next();
    
    assert(context.scope->forC);
    gen_emit(IR_JMP, context.scope->forC);
    return 0;
}

int prs_stmt_goto() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    lex_next();
    prs_expect_class(TK_IDENTIFIER); lex_next();
    prs_expect_char(';'); lex_next();
    
    return 0;
}

int prs_stmt_return() {
    PT_PRT_IND
    fprintf(stderr, "[keyword=%s]\n", lex_token.tk_str);
    
    var_st *v = NULL;
    
    lex_next();
    if(lex_token.tk_str[0] != ';') {
        v = prs_expr();
    }
    prs_expect_char(';'); lex_next();
    
    if(context.func->ret && v)
       gen_emit(IR_ASSIGN, context.func->ret, v);
    gen_emit(IR_RETURN);
    
    return 0;
}

int prs_stmt() {
    PRS_FUNC_BG
    PT_FUNC
    
    if(sym_islabel(&lex_token)) {
        /* => ID : statement */
        prs_stmt_label();
    }
    else if(lex_token.tk_class == TK_CASE) {
        /* => case constant-expression : statement */
        prs_stmt_case();
    }
    else if(lex_token.tk_class == TK_DEFAULT) {
        /* => default : statement */
        prs_stmt_default();
    }
    else if(lex_token.tk_class == TK_IF) {
        /* => if '(' expression ')' statement
         * => if '(' expression ')' statement else statement
         */
         prs_stmt_if();
    }
    else if(lex_token.tk_class == TK_SWITCH) {
        /* => switch '(' expression ') ' statement */
        prs_stmt_switch();
    }
    else if(lex_token.tk_class == TK_WHILE) {
        /* => while '(' expression ') ' statement */
        prs_stmt_while();
    }
    else if(lex_token.tk_class == TK_DO) {
        /* => do statement while '(' expression ')'; */
        prs_stmt_dowhile();
    }
    else if(lex_token.tk_class == TK_FOR) {
        /* => for '(' [ expression ] ; [ expression ] ; [ expression ] ')' statement */
        prs_stmt_for();
    }
    else if(lex_token.tk_class == TK_BREAK) {
        /* => break ; */
        prs_stmt_break();
    }
    else if(lex_token.tk_class == TK_CONTINUE) {
        /* => continue ; */
        prs_stmt_continue();
    }
    else if(lex_token.tk_class == TK_GOTO) {
        /* => break ; */
        prs_stmt_goto();
    }
    else if(lex_token.tk_class == TK_RETURN) {
        /* => return  [ expression ] ; */
        prs_stmt_return();
    }
    else if(lex_token.tk_str[0] == '{') {
        /* => '{' { declaration } { statement } '}' */
        /* TODO: need declaration */
        PT_PRT_IND
        fprintf(stderr, "stmt[{}]\n");
        
        lex_next();
        
        sym_mnp_scope();
        prs_decls();
        while(lex_token.tk_str[0] != '}') {
            prs_stmt();
        }
        sym_pop_scope();
        prs_expect_char('}'); lex_next(); 
        
        PT_PRT_IND
        fprintf(stderr, "prs_stmt[leave], next lex_token=%s\n", lex_token.tk_str);
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
    PRS_FUNC_BG
    PT_FUNC
    
    while(sym_hastype(&lex_token)) {
        prs_decl();
        fprintf(stderr, "\n");
    }
    
    PRS_FUNC_ED
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
    PRS_FUNC_BG
    PT_FUNC 
     
    type_st *type_base = prs_decl_spec();
    type_st *type = NULL;
    var_st  *var  = NULL;
    char vname[255];
    
    /* (possibly) Variable declaration
     * => init-declarator { , init-declarator } ; 
     * => identifier { ... }
     *    identifier = assignment-expression  { ... }
     */
    
    while(1) {
        var = NULL;
        type = type_base;
        
        while(lex_token.tk_str[0] == '*') {
            PT_PRT_IND
            fprintf(stderr, "operator[*]\n");
            
            lex_next();
            type = pointer_of(type);
        }
        
        prs_expect_class(TK_IDENTIFIER); 
        
        strcpy(vname, lex_token.tk_str);
        lex_next();
        
        PT_PRT_IND
        fprintf(stderr, "%s[name='%s']\n", lex_token.tk_str[0] == '(' ? "func" : "var", vname);
        
        if(lex_token.tk_str[0] != '(') {
            /* Variable declaration */
            var = sym_make_var(vname, type);
        }
        
        if(lex_token.tk_class == TK_OP_ASSIGN) {
            /* TODO */
            PT_PRT_IND
            fprintf(stderr, "operator[=]\n");
            lex_next();
            
            var_st *result = prs_assign();
            gen_emit(IR_ASSIGN, var, result);
        }
        
        if(lex_token.tk_str[0] == ',') lex_next();
        else break;
    }
    
    /* function declaration */
    if(lex_token.tk_str[0] == '(') { lex_next();
        /* => declaration-specifiers func-declarator compound-statement
         * => declaration-specifiers identifer '(' parameter-list ')'
         * where specifier & identifier are already parsed
         *
         * parameter-list: parameter { , parameter } [ , ... ]
         * parameter: declaration-specifiers identifier
         */
         
         sym_mnp_scope();
         func_st  *nfunc  = sym_make_func(vname, type);
         
         if(lex_token.tk_str[0] != ')') {
             /* parse parameters 
              * TODO: wrap in a indepedent parse function
              */
             while(1) {
                 char    *par_name;
                 type_st *par_type = prs_decl_spec();
                 
                 if(lex_token.tk_str[0] == '*') {
                    PT_PRT_IND
                    fprintf(stderr, "operator[*]\n");
                    lex_next();
                    
                    par_type = pointer_of(par_type);
                 }
                 
                 /* parameter name is not obligatory */
                 par_name = lex_token.tk_class == TK_IDENTIFIER ? dup_str(lex_token.tk_str) : NULL;
                
                 PT_PRT_IND
                 fprintf(stderr, "para[name='%s']\n", par_name);
                 if(par_name) lex_next();
                 
                 /* sym_make_par() should check if parameters declaration is consistent (in case of multiple declarations) */
                 sym_make_par(par_name, par_type);
                 if(lex_token.tk_str[0] == ',') lex_next();
                 else break;
             }
         }
         
         prs_expect_char(')'); lex_next();
         nfunc->declared = 1;
         
         if(lex_token.tk_str[0] == '{') {
             /* function definition */
             nfunc->defined = 1;
             /* make sure parameters all have names */
             assert(sym_is_full_pars(nfunc));
             prs_stmt();
         }
         else if(lex_token.tk_str[0] == ';') {
             lex_next();
         }
         sym_pop_scope();
         context.func = wrap_func;
    }
    else {
        prs_expect_char(';'); lex_next();
    }
    
    PRS_FUNC_ED
    return 0;
}

/* declaration-specifiers => 
 *   int
 */

type_st* prs_decl_spec() {
    PRS_FUNC_BG
    PT_FUNC 
     
    type_st* r;
     
    if(lex_token.tk_class == TK_INT) {
        lex_next();
        
        PT_PRT_IND
        fprintf(stderr, "type[int]\n");
        
        r = type_int;
    }
    
    PRS_FUNC_ED
    return r;
}

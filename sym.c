/* sym.c */
#include "zcc.h"
#include <memory.h>

context_st context;

/* =---- Symbol manager ----= */

type_st* type_int;

int sym_init() {
     
     /* initialize context */
     context.func  = NULL;
     context.scope = sym_make_scope();
     context.types = make_list;
     
     /* add native types */
     type_int = malloc(sizeof(int));
     type_int->bytes = sizeof(int);
     type_int->ref = NULL;
     type_int->name = "int";
     sym_add_type(type_int);
     
     type_st *type_int_ptr = malloc(sizeof(int*));
     type_int_ptr->bytes = sizeof(int*);
     type_int_ptr->ref = type_int;
     type_int_ptr->name = NULL;
     sym_add_type(type_int_ptr);
     
     return 0;
}

void sym_add_type(type_st *type) {
    list_append(context.types, type);
}

scope_st* sym_make_scope() {
    scope_st *scope = malloc(sizeof(scope_st));
    scope->up = NULL;
    scope->vars = make_list();
}

void sym_push_scope(scope_st *scope) {
    scope->up = context.scope;
    context.scope = scope;
}

void sym_pop_scope() {
    assert(context.scope != NULL);
    context.scope = context.scope->up;
}

scope_st* sym_mnp_scope() {
    scope_st *scope = sym_make_scope();
    sym_push_scope(scope);
    return scope;
}

var_st* sym_make_var(char* name, type_st* type) {
    /* TODO */
    return NULL;
}

var_st* sym_make_temp_var(type_st *type) {
    /* TODO */
}

var_st* sym_make_imm(lex_token* tk) {
    /* TODO */
}

var_st* sym_make_par(char* name, type_st* type) {
    /* TODO */
    return NULL;
}

func_st* sym_make_func(char* name, type_st* rtype) {
    /* TODO */
    return NULL;
}

int sym_hasid(token_st *tk) {
    /* TODO */
    return 1;
}

int sym_hastype(token_st *tk) {
    /* TODO */
    if(tk->tk_class == TK_INT) return 1;
    return 0;
}

int sym_islabel(token_st* tk) {
    /* TODO */
    return 0;
}
/* sym.c */
#include "zcc.h"
#include <memory.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

context_st context;

/* =---- Symbol manager ----= */

type_st* type_int;
type_st* type_int_ptr;
func_st* wrap_func;

int sym_init() {
     
     /* initialize context */
     context.func  = NULL;
     context.func  = wrap_func = sym_make_func("(top)", NULL); /* virtual wrap function */
     context.scope = sym_make_scope();
     context.types = make_list();
     context.funcs = make_list();
     
     context.ifT = context.ifF = context.ifE =
     context.whileB = context.whileE = 
     context.forB = context.forE = NULL;
     
     /* add native types */
     type_int = malloc(sizeof(int));
     type_int->bytes = sizeof(int);
     type_int->native = 1;
     type_int->ref = NULL;
     type_int->name = "int";
     sym_add_type(type_int);
     
     type_int_ptr = malloc(sizeof(int*));
     type_int_ptr->bytes = sizeof(int*);
     type_int_ptr->native = 1;
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
    return scope;
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
    var_st *var = malloc(sizeof(var_st));
    var->name = dup_str(name);
    var->type = type;
    var->value = NULL;
    var->ispar = 0;
    var->lvalue = 1;
    var->irname = NULL;
    sym_add_var(var);
    return var;
}

/* add to scope */
var_st* sym_add_var(var_st *var) {
    scope_st *scope = context.scope;
    list_st  *vars  = scope->vars;
    list_append(vars, var);
    return var;
}

var_st* sym_find_var(char *name) {
    scope_st *scope = context.scope;
    list_st  *vars;
    int i;
    while(scope) {
        vars = scope->vars;
        assert(vars);
        for(i = 0; i < vars->len; i++) {
            if(strcmp(name, ((var_st*)vars->elems[i])->name) == 0)
                return vars->elems[i];
        }
        scope = scope->up;
    }
    return NULL;
}

func_st* sym_find_func(char *name) {
    list_st *funcs = context.funcs;
    int i;
    for(i = 0; i < funcs->len; i++)
        if(strcmp(name, ((func_st*)funcs->elems[i])->name) == 0)
            return funcs->elems[i];
    return NULL;
}

var_st* sym_make_temp_var(type_st *type) {
    var_st *var = malloc(sizeof(var_st));
    var->name = NULL;
    var->type = type;
    var->value = NULL;
    var->ispar = 0;
    var->lvalue = 0;
    var->irname = NULL;
    /* dont add to scope */
    return var;
}

var_st* sym_make_imm(token_st* tk) {
    var_st *var = malloc(sizeof(var_st));
    /* support only int for now */
    var->type = tk->tk_class == TK_CONST_INT ? type_int : NULL;
    var->name = NULL;
    var->value = dup_value(tk->value);
    var->ispar = 0;
    var->irname = NULL;
    return var;
}

/* make var and add to scope */
var_st* sym_make_par(char* name, type_st* type) {
    func_st *func = context.func;
    list_st *pars = func->pars;
    var_st *var = malloc(sizeof(var_st));
    var->name = dup_str(name);
    var->type = type;
    var->value = NULL;
    var->ispar = pars->len + 1;
    var->lvalue = 1;
    var->irname = NULL;
    list_append(pars, var);
    sym_add_var(var);
    return var;
}

/* make var and set it as context.func */
func_st* sym_make_func(char* name, type_st* rtype) {
    func_st *func = malloc(sizeof(func_st));
    func->name = dup_str(name);
    func->rtype = rtype;
    func->pars  = make_list();
    func->insts = make_list();
    func->ret   = NULL;
    assert(context.func == NULL || strcmp(context.func->name, "(top)") == 0); /* dont allow nested function */
    context.func = func;
    return func;
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

label_st* sym_make_label() {
    label_st *label = malloc(sizeof(label_st));
    label->func     = context.func;
    label->chain    = NULL;
    label->irname   = NULL;
    return label;
}

type_st* pointer_of(type_st* type) {
    list_st *types = context.types;
    int i = 0;
    for(; i < types->len; i++) {
        if(((type_st*)types->elems[i])->ref == type)
            return types->elems[i];
    }
    /* pointer type not found. create one */
    type_st *ntype = malloc(sizeof(type_st));
    ntype->bytes = sizeof(void*);
    ntype->native = 0;
    ntype->ref = type;
    ntype->name = NULL;
    
    sym_add_type(ntype);
    return ntype;
}
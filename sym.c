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
type_st* type_char;
type_st* type_char_ptr;
func_st* wrap_func;
static list_st *disposed_temp_vars;

int sym_init() {
     
     /* initialize context */
     context.funcs = make_list();
     context.func  = wrap_func = sym_make_func("(top)", NULL); /* virtual wrap function */
     context.scope = sym_make_scope();
     context.types = make_list();
     context.cstr  = make_list();
     
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
     
     type_char = malloc(sizeof(char));
     type_char->bytes = sizeof(char);
     type_char->native = 1;
     type_char->ref = NULL;
     type_char->name = "char";
     sym_add_type(type_char);
     
     type_char_ptr = malloc(sizeof(char*));
     type_char_ptr->bytes = sizeof(char*);
     type_char_ptr->native = 1;
     type_char_ptr->ref = type_char;
     type_char_ptr->name = NULL;
     sym_add_type(type_char_ptr);
     
     disposed_temp_vars = NULL;
     
     return 0;
}

void sym_add_type(type_st *type) {
    list_append(context.types, type);
}

scope_st* sym_make_scope() {
    scope_st *scope = malloc(sizeof(scope_st));
    scope->up = NULL;
    scope->vars = make_list();
    scope->forB = scope->forE = scope->forC = NULL;
    return scope;
}

void sym_push_scope(scope_st *scope) {
    scope->up = context.scope;
    scope->forB = scope->up->forB;
    scope->forC = scope->up->forC;
    scope->forE = scope->up->forE;
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
    if(sym_redefined_var(name)) {
        fprintf(stderr, "Fatal: var[name=%s] redefine.\n", name);
        fexit("");
        return NULL;
    }
    
    var_st *var = malloc(sizeof(var_st));
    var->name = dup_str(name);
    var->type = type;
    var->value = NULL;
    var->ispar = 0;
    var->lvalue = 1;
    
    var->irname = NULL;
    var->addr   = 0;
    sym_add_var(var);
    return var;
}

/* add to scope */
var_st* sym_add_var(var_st *var) {    
    func_st *func   = context.func;
    scope_st *scope = context.scope;
    list_st  *vars  = scope->vars;
    list_append(vars, var);
    var->where = STACK_VAR;
    var->ref   = 0;
    /* allocate space for local variable in stack frame */
    if(func != wrap_func) {
        var->addr = func->rbytes;
        func->rbytes += 8; /* max size for var is 8 bytes */
    }
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
    var_st *var;
    func_st *func = context.func;
    assert(func != wrap_func);
    
    if(!list_isempty(disposed_temp_vars)) {
        var = list_pop(disposed_temp_vars);
    }
    else {
        var = malloc(sizeof(var_st));
        var->irname = NULL;
        /* allocate space in stack frame */
        var->where = STACK_VAR;
        var->ref   = 0;
        var->addr = func->rbytes;
        func->rbytes += 8; /* always align to 8 bytes */
        /* dont add to scope */
    }
    var->name = NULL;
    var->type = type;
    var->value = NULL;
    var->ispar = 0;
    var->lvalue = 0;
    return var;
}

/* TODO: explain ref */
var_st* sym_make_temp_lvar(type_st *type, int ref) { 
    var_st *var = sym_make_temp_var(type);
    var->lvalue = 1;
    var->ref = ref;
    return var;
}

void sym_dispose_temp_var(var_st *var) {
    if(var->lvalue == 0 && var->value == NULL) {
        var->value = NULL;
        list_append(disposed_temp_vars, var);
    }
}

var_st* sym_make_imm(token_st* tk) {
    var_st *var = malloc(sizeof(var_st));
    var->irname = NULL;
    var->addr = -1;
    /* support only int for now */
    if(tk->tk_class == TK_CONST_INT) {
        var->type = type_int;
        var->name = NULL;
        var->value = dup_value(tk);
        var->ispar = 0;
        var->lvalue = 0;
    }
    else if(tk->tk_class == TK_CONST_STRING) {
        var->type = type_char_ptr;
        var->name = NULL;
        var->value = dup_value(tk);
        //fprintf(stderr, "var->value->s=%s\n", var->value->s);
        var->ispar = 0;
        var->lvalue = 0;
        list_append(context.cstr, var);
    }
    else {
        fexit("Unsupported const type");
    }
    return var;
}

int sym_redefined_var(char *name) {
    scope_st *scope = context.scope;
    list_st  *vars = scope->vars;
    int i;
    assert(vars);
    for(i = 0; i < vars->len; i++) {
        if(strcmp(name, ((var_st*)vars->elems[i])->name) == 0)
            return 1;
    }
    return 0;
}

/* make par and add to scope */
var_st* sym_make_par(char* name, type_st* type) {
    static func_st *func = NULL;
    static int par_ind;
    
    if(context.func != func) {
        func = context.func;
        par_ind = 0;
    }
    else par_ind++;
    list_st *pars = func->pars;
    
    if(func->declared) {
        /* check declaration consistency */
        var_st *var = pars->elems[par_ind];
        assert(par_ind < pars->len);
        assert(var->type == type);
        sym_add_var(var);
        return var;
    }
    else {        
        /* add new parameter to list */
        if(sym_redefined_var(name)) {
            fprintf(stderr, "Fatal: var[name=%s] redefine.\n", name);
            fexit("");
            return NULL;
        }
        
        var_st *var = malloc(sizeof(var_st));
        var->name = dup_str(name);
        var->type = type;
        var->value = NULL;
        var->ispar = pars->len + 1;
        var->lvalue = 1;
        var->irname = NULL;
        list_append(pars, var);
        /* add to scope. Note that sym_add_var() will allocate space in stack frame. 
         * this is intended for it's easier to manipulte linear stack-placed args 
         * (rather than part in register and part on stack)
         */
        sym_add_var(var);
        return var;
    }
}

/* make var and set it as context.func */
func_st* sym_make_func(char* name, type_st* rtype) {    
    func_st *func = sym_find_func(name);
    if(func) {
        assert(rtype == func->rtype);
        if(disposed_temp_vars) free(disposed_temp_vars);
        disposed_temp_vars = make_list();
        context.func = func;
        return func;
    }
    func = malloc(sizeof(func_st));
    func->name = dup_str(name);
    func->rtype = rtype;
    func->pars  = make_list();
    func->insts = make_list();
    func->ret   = NULL;
    func->rbytes = 0;
    func->declared = 0;
    func->defined = 0;
    assert(context.func == NULL || strcmp(context.func->name, "(top)") == 0); /* dont allow nested function */
    context.func = func;
    list_append(context.funcs, func); /* should append early to allow recursive */
    
    if(disposed_temp_vars) free(disposed_temp_vars);
    disposed_temp_vars = make_list();
    
    /* reserve space in stack frame for return value 
     * this simplify IR_RETURN. (i.e. not need to pass argument by IR_RETURN)
     */
    func->ret = rtype ? sym_make_temp_var(rtype) : NULL;
    
    return func;
}

/* workaround for call to printf when pre-declaration is not implemented */
func_st* sym_make_temp_func(char* name, type_st* rtype) {
    func_st *func = malloc(sizeof(func_st));
    func->name = dup_str(name);
    func->rtype = rtype;
    func->pars  = NULL;
    func->insts = NULL;
    func->ret   = NULL;
    func->rbytes = 0;
    func->declared = 0;
    func->defined = 0;
    
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

int sym_is_pointer(var_st* v) {
    return v->type->ref != NULL;
}

int sym_is_full_pars(func_st* f) {
    list_st *pars = f->pars;
    int i, yes = 1;
    for(i = 0; i < pars->len; i++)
        if(((var_st*)pars->elems[i])->name == NULL) {
            yes = 0;
            break;
        }
    return yes;
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
    ntype->bytes = 8;
    ntype->native = 0;
    ntype->ref = type;
    ntype->name = NULL;
    
    sym_add_type(ntype);
    return ntype;
}
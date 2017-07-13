/* gen.c */
#include "zcc.h"
#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

static void emit(inst_st* inst) {
    func_st *func  = context.func;
    assert(func);
    list_st *insts = func->insts;
    assert(insts);
    list_append(insts, inst);
}

static inst_st* make_inst(ir_op_en op) {
    inst_st *r = malloc(sizeof(inst_st));
    r->op = op;
    return r;
}

void gen_emit0(ir_op_en op) {
    emit(make_inst(op));
}

void gen_emit1(ir_op_en op, var_st* var) {
    inst_st *inst = make_inst(op);
    inst->args[0] = var;
    emit(inst);
}

void gen_emit2(ir_op_en op, var_st* arg0, var_st* arg1) {
    inst_st *inst = make_inst(op);
    inst->args[0] = arg0; inst->args[1] = arg1;
    emit(inst);
}

void gen_emit3(ir_op_en op, var_st* arg0, var_st* arg1, var_st* arg2) {
    inst_st *inst = make_inst(op);
    inst->args[0] = arg0; inst->args[1] = arg1; inst->args[2] = arg2;
    emit(inst);
}

void gen_emit_call(ir_op_en op, func_st* func, var_st *rvar, list_st *args) {
    inst_st *inst = make_inst(op);
    inst->args[0] = func; inst->args[1] = rvar; inst->args[2] = args;
    emit(inst);
}

static list_st *tvars;
static char* name_var(var_st *);

static void print_var(var_st *v) {
    if(v->value) {
        printf("const[");
        if(v->type == type_int) printf("%d]", v->value->i);
        else {
            /* TODO */
        }
    }
    else {
        printf("var[%s %s]", v->type->name, name_var(v));
    }    
    printf("\t");
}

static char* name_var(var_st *var) {
    static char strs[256];
    char *name;
    if(var->irname) return var->irname;
    if(var->name) name = var->name;
    else {
        int i = list_index(tvars, var);
        if(i == -1) {
            i = tvars->len;
            list_append(tvars, var);
        }
        name = strs;
        sprintf(name, "V%d", i);
    }
    printf("var[%s %s]", var->type->name, var->name);
    return var->irname = name;
}

static void print_args(list_st *args) {
    int i;
    for(i = 0; i < args->len; i++) {
        print_var(args->elems[i]);
    }
}

void gen_print_func_ir(func_st* func) {
    list_st *insts = func->insts;
    list_st *args  = func->pars;
    tvars = make_list();
    int i;
    
    printf("Func[name=%s, rtype=%s, args=["
        , func->name
        , func->rtype ? "void" : func->rtype->name);
    for(i = 0; i < args->len; i++) {
        var_st *var = args->elems[i];
        if(i > 0) printf(", ");
        if(var->value) {
            printf("const[");
            if(var->type == type_int) printf("%d]", var->value->i);
            else {
                /* TODO: support of string and char */
                fexit("string & char not supported");
            }
        }
        else {            
            printf("var[%s %s]", var->type->name, name_var(var));
        }
    }
    printf("]");
    
    for(i = 0; i < insts->len; i++) {
        inst_st *inst = insts->elems[i];
        void **args = inst->args;
        printf("    ");
        
        if(inst->op == IR_ASSIGN) {
            printf("mov\t");
            print_var(args[0]); print_var(args[1]); 
        }
        else if(inst->op == IR_ADD) {
            printf("add\t");
            print_var(args[0]); print_var(args[1]); print_var(args[2]); 
        }
        else if(inst->op == IR_CALL) {
            printf("mov\t");
            print_var(args[1]); 
            printf("call %s\t", ((func_st*)args[0])->name); 
            print_args(args[1]);
        }
        else if(inst->op == IR_RETURN) {
            printf("ret");
        }
        printf("\n");
    }
    printf("\n");
}
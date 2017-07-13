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

void gen_emit1(ir_op_en op, void* var) {
    inst_st *inst = make_inst(op);
    inst->args[0] = var;
    emit(inst);
}

void gen_emit2(ir_op_en op, void* arg0, void* arg1) {
    inst_st *inst = make_inst(op);
    inst->args[0] = arg0; inst->args[1] = arg1;
    emit(inst);
}

void gen_emit3(ir_op_en op, void* arg0, void* arg1, void* arg2) {
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
static list_st *tlabels;
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
        printf("%s[%s]", v->type->name, name_var(v));
    }    
    //printf("\t");
}

static void print_var_t(var_st *v) {
    print_var(v); printf("\t");
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
    //printf("var[%s %s]", var->type->name, var->name);
    return var->irname = dup_str(name);
}

static void print_args(list_st *args) {
    int i;
    //fprintf(stderr, "args[len=%d, addr=%x]\n", args->len, args);
    printf("(");
    for(i = 0; i < args->len; i++) {
        if(i > 0) printf(", ");
        print_var(args->elems[i]);
    }
    printf(")");
}

static char* name_label(label_st *label_) {
    static char str[256];
    label_st *label = label_;
    if(label->irname) return label->irname;
    while(label->chain) label = label->chain;
    if(label->irname == NULL) {
        sprintf(str, "L%d", tlabels->len);
        list_append(tlabels, label);
        label->irname = dup_str(str);
    }
    return label_->irname = label->irname;
}

void gen_print_func_ir(func_st* func) {
    list_st *insts = func->insts;
    list_st *args  = func->pars;
    tvars   = make_list();
    tlabels = make_list();
    int i;
    
    printf("Func[name=%s, rtype=%s, rvar=%s, args=["
        , func->name
        , func->rtype ? func->rtype->name : "void"
        , name_var(func->ret));
    
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
            print_var(var);
        }
    }
    printf("]]\n");
    
    for(i = 0; i < insts->len; i++) {
        inst_st *inst = insts->elems[i];
        void **args = inst->args;
        printf("    ");
        
        //fprintf(stderr, "inst=%x\n", inst);
        if(inst->op == IR_ASSIGN) {
            printf("mov\t");
            print_var_t(args[0]); print_var_t(args[1]); 
        }
        else if(inst->op == IR_ADD) {
            printf("add\t");
            print_var_t(args[0]); print_var_t(args[1]); print_var_t(args[2]); 
        }
        else if(inst->op == IR_CALL) {
            printf("mov\t");
            print_var_t(args[1]); 
            printf("call %s", ((func_st*)args[0])->name); 
            print_args(args[2]);
        }
        else if(inst->op == IR_RETURN) {
            printf("ret");
        }
        else if(inst->op == IR_LABEL) {
            printf("label %s", name_label(args[0]));
        }
        else if(inst->op == IR_JMP) {
            printf("jmp %s", name_label(args[0]));
        }
        else if(inst->op == IR_CJMP) {
            printf("cjmp %s %s", name_var(args[0]), name_label(args[1]));
        }
        printf("\n");
    }
    printf("\n");
}
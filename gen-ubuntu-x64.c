/* gen-ubuntu-x64.c. Assembly generator for ubuntu x64. 
 * link corresponding gen-x.c for different target platform.
 */
#include "zcc.h"
#include <string.h>
#include <stdio.h>
#include <assert.h>

/* TODO: optimazation: merge load & save to move */

typedef enum regs_en { RAX=0, RBX, RCX, RDX, RSI, RDI, RBP, R8, R9, R10, R11, R12, R13, R14, R15, RIP } regs_en;
char *regs_name[] = { "ax", "bx", "cx", "dx", "si", "di", "bp", "8", "9", "10", "11", "12", "13", "14", "15", "ip" };
static FILE *fp;
static list_st *tlabels; /* label should be global across assembly */

#define pp(op)   fprintf(fp, "\t " #op "\n")
#define prt(...) fprintf(fp, __VA_ARGS__)
#define endl     fprintf(fp, "\n")

#define ld(addr) (-((addr) + 8)) /* offset from %rbp */
#define ldd(v) ld(((var_st*)v)->addr) /* load varible address */

#define ireg1(op, x)    ireg1_f(#op, x)
#define ireg2(op, x, y) ireg2_f(#op, x, y)

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

static void gen_global(func_st* f) {
    /* TODO: support global variable */
    
    /* put constant string in .rodata */
    char sname[56];
    list_st *cstr = context.cstr;
    var_st  *sv;
    int i;
    
    prt("\t .section\t .rodata\n");
    for(i = 0; i < cstr->len; i++) {
        sv = cstr->elems[i];
        sprintf(sname, "S%d", i);
        sv->irname = dup_str(sname);
        prt(".%s:\n", sname);
        prt("\t .string \"%s\"\n", sv->value->s);
    }
}

/***
 * Variable to assembly
 * 1. const
 * 2. variable
 */
static char* v2a(var_st *v) {
    /* deprecated */
    static char str[256];
    /* TODO: support other types */
    if(v->value) {
        if(v->type == type_int) 
            sprintf(str, "$%d", v->value->i);
        else if(v->type == type_char_ptr)
            sprintf(str, "$.%s", v->irname);
    }
    else {
        sprintf(str, "%d(%%rbp)", ldd(v));
    }
    return str;
}

void ireg1_f(char* op, regs_en x) {
    prt("\t %s\t %%r%s\n", op, regs_name[x]);
}

void ireg2_f(char *op, regs_en x, regs_en y) {
    prt("\t %s\t %%r%s, %%r%s\n", op, regs_name[x], regs_name[y]);
}

void load(var_st *v, regs_en r) {
    char *rprefix = v->type->bytes == 4 ? "e" : "r";
    char *rname = regs_name[r];
    if(v->value) {
        if(v->type == type_int) 
            prt("\t mov\t $%d, %%e%s\n", v->value->i, rname);
        else if(v->type == type_char_ptr) {
            prt("\t mov\t $.%s, %%r%s\n", v->irname, rname);
        }
        else 
            assert("Not supported type");
    }
    else {
        if(v->ref == 0) {
            if(v->where == STACK_VAR)
                prt("\t mov\t %d(%%rbp), %%%s%s\n", ldd(v),  rprefix, rname);
            else 
                prt("\t mov\t %s(%%rip), %%%s%s\n", v->name, rprefix, rname);
        }
        else {
            if(v->where == STACK_VAR) {
                /* dont use register other than r */
                prt("\t mov\t %d(%%rbp), %%r%s\n", ldd(v), rname);
                prt("\t mov\t (%%r%s), %%%s%s\n", rname, rprefix, rname);
            }
            else {
                prt("\t mov\t %s(%%rip), %%r%s\n", v->name, rname);
                prt("\t mov\t (%%r%s), %%%s%s\n", rname, rprefix, rname);
            }
        }
    }
}

void loadx(char *movx, var_st *v, regs_en r) {
    char *rname = regs_name[r];
    if(v->type->bytes == 8) {
        load(v, r);
        return;
    }
    if(v->value) {
        if(v->type == type_int) 
            prt("\t mov\t $%d, %%r%s\n", v->value->i, rname);
        else if(v->type == type_char_ptr)
            prt("\t mov\t $.%s, %%r%s\n", v->irname, rname);
        else 
            assert("Not supported type");
    }
    else {
        if(v->ref == 0) {
            if(v->where == STACK_VAR)
                prt("\t %s\t %d(%%rbp), %%r%s\n", movx, ldd(v),  rname);
            else 
                prt("\t %s\t %s(%%rip), %%r%s\n", movx, v->name, rname);
        }
        else {
            if(v->where == STACK_VAR) {
                /* dont use register other than r */
                prt("\t mov\t %d(%%rbp), %%r%s\n", ldd(v), rname);
                prt("\t %s\t (%%r%s), %%r%s\n", movx, rname, rname);
            }
            else {
                prt("\t mov\t %s(%%rip), %%r%s\n", v->name, rname);
                prt("\t %s\t (%%r%s), %%r%s\n", movx, rname, rname);
            }
        }
    }
}

void loadzx(var_st *v, regs_en r) {
    loadx("movzx", v, r);
}

void loadsx(var_st *v, regs_en r) {
    loadx("movsx", v, r);
}

void save(regs_en r, var_st *v) {
    char *rprefix = v->type->bytes == 4 ? "e" : "r";
    char *rname = regs_name[r], *r2name = r == RAX ? "bx" : "ax";
    //assert(v->lvalue);
    if(v->ref == 0) {
        if(v->where == STACK_VAR)
            prt("\t mov\t %%%s%s, %d(%%rbp)\n", rprefix, rname, ldd(v));
        else 
            prt("\t mov\t %%%s%s, %s(%%rip)\n", rprefix, rname, v->name);
    }
    else {
        if(v->where == STACK_VAR) {
            prt("\t mov\t %d(%%rbp), %%r%s\n", ldd(v), r2name);
            prt("\t mov\t %%%s%s, (%%r%s)\n", rprefix, rname, r2name);
        }
        else {
            prt("\t mov\t %s(%%rip), %%r%s\n", v->name, r2name);
            prt("\t mov\t %%%s%s, (%%r%s)\n", rprefix, rname, r2name);
        }
    }
}

static void gen_func(func_st *f) {
    //printf("\n");
    //gen_print_func_ir(f);
    
    /***
    	.globl	main
        .type	main, @function
    main:
        pushq	%rbp
        movq	%rsp, %rbp
    */
    if(!f->defined) return;
    prt("\t .globl\t%s\n", f->name);
    prt("\t .type\t%s, @function\n", f->name);
    prt("%s:\n", f->name);
    prt("\t pushq\t%%rbp\n");
    prt("\t movq\t%%rsp, %%rbp\n");
    /* reserve space for local & temp variables */
    prt("\t subq\t$%d, %%rsp\n", f->rbytes+8);
    
    int i, j;
    list_st *insts = f->insts;
    list_st *args  = f->pars;
    enum regs_en arg_regs[] = { RDI, RSI, RDX, RCX, R8, R9 };
    
    /* place argments on stack 
     * ref. http://eli.thegreenplace.net/2011/09/06/stack-frame-layout-on-x86-64/
     */
    for(i = 0; i < args->len; i++) {
        var_st *arg = args->elems[i];
        if(i < 6) {
            /* first 6 args are in 
             * rdi, rsi, rdx, rcx, r8, r9
             * respectively
             */ 
            prt("\t mov\t%%r%s, %d(%%rbp)\n", regs_name[arg_regs[i]], ldd(arg));
        }
        else {
            prt("\t mov\t%d(%%rbp), %%rdi\n", 8 * (i - 6) + 16);
            prt("\t mov\t%%rdi, %d(%%rbp)\n", ldd(arg));
        }
    }
    endl;
    
    for(i = 0; i < insts->len; i++) {
        inst_st *inst = insts->elems[i];
        void **args   = inst->args;
        
        if(inst->op == IR_ASSIGN) {
            var_st *d = args[0], *s = args[1];
            load(s, RDI);
            save(RDI, d);
        }
        else if(inst->op == IR_ADD) {
            var_st *d = args[0], *x = args[1], *y = args[2];
            load(x, RDI);
            load(y, RSI);
            ireg2(add, RDI, RSI);
            save(RSI, d);
        }
        else if(inst->op == IR_SUB) {
            var_st *d = args[0], *x = args[1], *y = args[2];
            load(x, RDI);
            load(y, RSI);
            ireg2(sub, RSI, RDI);
            save(RDI, d);
        }
        else if(inst->op == IR_MUL) {
            var_st *d = args[0], *x = args[1], *y = args[2];
            load(x, RDI);
            load(y, RSI);
            ireg2(imul, RDI, RSI);
            save(RSI, d);
        }
        else if(inst->op == IR_CALL) {
            func_st *func = args[0];
            var_st *r = args[1];
            list_st *fargs = args[2];
            for(j = 0; j < fargs->len && j < 6; j++) {
                var_st *var = fargs->elems[j];
                load(var, RAX);
                prt("\t mov\t %%r%s, %%r%s\n", regs_name[RAX], regs_name[arg_regs[j]]);
            }
            for(j = fargs->len-1; j >= 6; j--) {
                var_st *var = fargs->elems[j];
                load(var, RAX);
                ireg1(push, RAX);
            }
            /* %rax set to number of floating argments. 
             * ref. System V ABI https://software.intel.com/sites/default/files/article/402129/mpx-linux64-abi.pdf
             */
            prt("\t mov\t $0, %%rax\n"); 
            prt("\t call\t%s\n", func->name);
            save(RAX, r);
        }
        else if(inst->op == IR_RETURN) {
            if(f->ret)
                load(f->ret, RAX);
            pp(leave);
            pp(ret);
        }
        else if(inst->op == IR_LABEL) {
            prt(".%s:\n", name_label(inst->args[0]));
        }
        else if(inst->op == IR_JMP) {
            prt("\t jmp\t.%s\n", name_label(args[0]));
        }
        else if(inst->op == IR_CJMP) {
            loadzx(args[0], RAX);
            prt("\t cmp\t $1, %%rax\n");
            prt("\t je\t .%s\n", name_label(args[1]));
        }
        else if(inst->op == IR_LT) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            loadsx(x, RDI);
            loadsx(y, RSI);
            ireg2(cmp, RSI, RDI);
            prt("\t setl\t %%al\n");
            prt("\t movzx\t %%al, %%rax\n");
            save(RAX, r);
        }
        else if(inst->op == IR_LE) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            loadsx(x, RDI);
            loadsx(y, RSI);
            ireg2(cmp, RSI, RDI);
            prt("\t setle\t %%al\n");
            prt("\t movzx\t %%al, %%rax\n");
            save(RAX, r);
        }
        else if(inst->op == IR_EQ) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            loadsx(x, RDI);
            loadsx(y, RSI);
            ireg2(cmp, RSI, RDI);
            prt("\t seteq\t %%al\n");
            prt("\t movzx\t %%al, %%rax\n");
            save(RAX, r);
        }
        else if(inst->op == IR_GT) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            loadsx(x, RDI);
            loadsx(y, RSI);
            ireg2(cmp, RSI, RDI);
            prt("\t setg\t %%al\n");
            prt("\t movzx\t %%al, %%rax\n");
            save(RAX, r);
        }
        else if(inst->op == IR_GE) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            loadsx(x, RDI);
            loadsx(y, RSI);
            ireg2(cmp, RSI, RDI);
            prt("\t setge\t %%al\n");
            prt("\t movzx\t %%al, %%rax\n");
            save(RAX, r);
        }
        else if(inst->op == IR_NEQ) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            loadsx(x, RDI);
            loadsx(y, RSI);
            ireg2(cmp, RSI, RDI);
            prt("\t setne\t %%al\n");
            prt("\t movzx\t %%al, %%rax\n");
            save(RAX, r);
        }
        else if(inst->op == IR_INC) {
            var_st *v = args[0];
            load(v, RAX);
            ireg1(inc, RAX);
            save(RAX, v);
        }
        else if(inst->op == IR_DEC) {
            var_st *v = args[0];
            load(v, RAX);
            ireg1(dec, RAX);
            save(RAX, v);
        }
        else if(inst->op == IR_IND) {
            /* D <- B[I], D is always an temporray lvalue on stack */
            var_st *d = args[0], *b = args[1], *i = args[2];
            int size = b->type->ref->bytes;
            loadsx(i, RAX);
            prt("\t leaq\t 0(,%%rax,%d), %%rdi\n", size);
            load(b, RAX);
            ireg2(add, RAX, RDI);
            //save(RDI, d);
            /* NOTE: should not use save(RDI, d)
             * because we are not setting value of varible but the address of it 
             */
             prt("\t mov\t %%rdi, %d(%%rbp)\n", ldd(d));
        }
        else if(inst->op == IR_OFFSET) {
            var_st *d = args[0], *v = args[1];
            int size = (int)args[2];
            loadsx(v, RAX);
            prt("\t leaq\t 0(,%%rax,%d), %%rdi\n", size);
            save(RDI, d);
        }
        else fexit("Unexpected IR instruction");
        endl;
    }
}

void gen_assembly(FILE *fp_) {
    list_st *funcs = context.funcs;
    int i;
    fp = fp_;
    tlabels = make_list();
    gen_global(wrap_func);
    
    prt("\t.text\n");
    /* start from 1 to skip wrap function. */
    for(i = 1; i < funcs->len; i++)
        gen_func(funcs->elems[i]);
}

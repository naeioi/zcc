/* gen-ubuntu-x64.c. Assembly generator for ubuntu x64. 
 * link corresponding gen-x.c for different target platform.
 */
#include "zcc.h"
#include <string.h>
#include <stdio.h>

static FILE *fp;
static list_st *tlabels; /* label should be global across assembly */

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

#define pp(op)   fprintf(fp, "\t" #op "\n")
#define prt(...) fprintf(fp, __VA_ARGS__)
#define endl     fprintf("\n")

static void gen_global(func_st* f) {
    /* TODO: support global variable */
}

static void gen_func(func_st *f) {
    /***
    	.globl	main
        .type	main, @function
    main:
        pushq	%rbp
        movq	%rsp, %rbp
    */
    prt("\t.globl\t%s\n", f->name);
    prt("\t.type\t%s, @function\n", f->name);
    prt("%s:\n", f->name);
    prt("\tpushq\t%%rbp\n");
    prt("\tmovq\t%%rsp, %%rbp\n");
    /* reserve space for local & temp variables */
    prt("\tsubq\t$%d, %%rsp\n", f->rbytes);
    
    int i, j;
    list_st *insts = f->insts;
    list_st *args  = f->pars;
    char *regs[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9" };
    
    #define ld(addr) (-((addr) + 8)) /* offset from %rbp */
    #define ldd(v) ld(((var_st*)v)->addr)
    
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
            prt("\tmov\t%%%s, %d(%%rbp)\n", regs[i], ldd(arg));
        }
        else {
            prt("\tmov\t%d(%%rbp), %%rdi\n", 8 * (i - 6) + 16);
            prt("\tmov\t%%rdi, %d(%%rbp)\n", ldd(arg));
        }
    }
    
    for(i = 0; i < insts->len; i++) {
        inst_st *inst = insts->elems[i];
        void **args   = inst->args;
        
        prt("\t");
        if(inst->op == IR_ASSIGN) {
            var_st *d = args[0], *s = args[1];
            prt("\tmov\t%d(%%rbp), %%edi\n", ldd(s));
            prt("\tmov\t%%edi, %d(%%rbp)\n", ldd(d));
        }
        else if(inst->op == IR_ADD) {
            var_st *d = args[0], *x = args[1], *y = args[2];
            prt("\tmov\t%%edi, %d(%%rbp)\n", ldd(x));
            prt("\tadd\t%%edi, %d(%%rbp)\n", ldd(y));
            prt("\tmov\t%d(%%rbp), %%edi", ldd(d));
        }
        else if(inst->op == IR_CALL) {
            func_st *func = args[0];
            var_st *r = args[1];
            list_st *fargs = args[2];
            for(j = 0; j < fargs->len && j < 6; j++) {
                prt("\tmov\t%d(%%rbp), %%ebx\n", ldd(fargs->elems[j]));
                prt("\tmov\t%%rbx, %%%s\n", regs[j]);
            }
            for(j = fargs->len-1; j >= 6; j--) {
                prt("\tmov\t%d(%%rbp), %%ebx\n", ldd(fargs->elems[j]));
                prt("\tpush\t%%rbx\n");
            }
            prt("\tcall\t%s\n", func->name);
            prt("\tmov\t%%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_RETURN) {
            pp(leave);
            pp(ret);
        }
        else if(inst->op == IR_LABEL) {
            prt("%s:\n", name_label(inst->args[0]));
        }
        else if(inst->op == IR_JMP) {
            prt("\tjmp\t.%s\n", name_label(args[0]));
        }
        else if(inst->op == IR_CJMP) {
            prt("\t cmpl \t %d(%%rbp) \t $1\n", ldd(args[0]));
            prt("\t je \t %s\n", name_label(args[1]));
            //printf("cjmp %s %s", ldd(args[0]), name_label(args[1]));
        }
        else if(inst->op == IR_LT) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov \t %d(%%rbp) \t %%edi\n", ldd(x));
            prt("\t cmp \t %%edi \t %d(%%rbp)\n", ldd(y));
            prt("\t setl \t %%al %%eax\n");
            prt("\t mov \t %%eax \t %d(%%rbp)\n", ldd(r));
            //printf("lt ");
            //print_var_t(args[0]); print_var_t(args[1]); print_var_t(args[2]); 
        }
        else if(inst->op == IR_LE) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov \t %d(%%rbp) \t %%edi\n", ldd(x));
            prt("\t cmp \t %%edi \t %d(%%rbp)\n", ldd(y));
            prt("\t setle \t %%al %%eax\n");
            prt("\t mov \t %%eax \t %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_EQ) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov \t %d(%%rbp) \t %%edi\n", ldd(x));
            prt("\t cmp \t %%edi \t %d(%%rbp)\n", ldd(y));
            prt("\t sete \t %%al %%eax\n");
            prt("\t mov \t %%eax \t %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_GT) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov \t %d(%%rbp) \t %%edi\n", ldd(x));
            prt("\t cmp \t %%edi \t %d(%%rbp)\n", ldd(y));
            prt("\t setg \t %%al %%eax\n");
            prt("\t mov \t %%eax \t %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_GE) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov \t %d(%%rbp) \t %%edi\n", ldd(x));
            prt("\t cmp \t %%edi \t %d(%%rbp)\n", ldd(y));
            prt("\t setge \t %%al %%eax\n");
            prt("\t mov \t %%eax \t %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_NEQ) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov \t %d(%%rbp) \t %%edi\n", ldd(x));
            prt("\t cmp \t %%edi \t %d(%%rbp)\n", ldd(y));
            prt("\t setne \t %%al %%eax\n");
            prt("\t mov \t %%eax \t %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_INC) {
            var_st *v = args[0];
            prt("\t inc \t %d(%%rbp)\n", ldd(v));
        }
        else if(inst->op == IR_DEC) {
            var_st *v = args[0];
            prt("\t dec \t %d(%%rbp)\n", ldd(v));
        }
        else fexit("Unexpected IR instruction");
        printf("\n");
    }
}

void gen_assembly(FILE *fp_) {
    list_st *funcs = context.funcs;
    int i;
    fp = fp_;
    gen_global(wrap_func);
    for(i = 0; i < funcs->len; i++)
        gen_func(funcs->elems[i]);
}

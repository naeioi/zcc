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

#define pp(op)   fprintf(fp, "\t " #op "\n")
#define prt(...) fprintf(fp, __VA_ARGS__)
#define endl     fprintf(fp, "\n")

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
#define ld(addr) (-((addr) + 8)) /* offset from %rbp */
#define ldd(v) ld(((var_st*)v)->addr) /* load varible address */
static char* v2a(var_st *v) {
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
    char *regs[] = { "rdi", "rsi", "rdx", "rcx", "r8", "r9" };
    
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
            prt("\t mov\t%%%s, %d(%%rbp)\n", regs[i], ldd(arg));
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
            prt("\t mov\t %s, %%edi\n", v2a(s));
            prt("\t mov\t %%edi, %d(%%rbp)\n", ldd(d));
        }
        else if(inst->op == IR_ADD) {
            var_st *d = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t add\t %s, %%edi\n", v2a(y));
            prt("\t mov\t %%edi, %d(%%rbp)\n", ldd(d));
        }
        else if(inst->op == IR_SUB) {
            var_st *d = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t sub\t %s, %%edi\n", v2a(y));
            prt("\t mov\t %%edi, %d(%%rbp)\n", ldd(d));
        }
        else if(inst->op == IR_MUL) {
            var_st *d = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t imull\t %s, %%edi\n", v2a(y));
            prt("\t mov\t %%edi, %d(%%rbp)\n", ldd(d));
        }
        else if(inst->op == IR_CALL) {
            func_st *func = args[0];
            var_st *r = args[1];
            list_st *fargs = args[2];
            for(j = 0; j < fargs->len && j < 6; j++) {
                var_st *var = fargs->elems[j];
                if(var->value) {
                    prt("\t mov\t %s, %%%s\n", v2a(var), regs[j]);
                }
                else {
                    prt("\t mov\t %s, %%ebx\n", v2a(fargs->elems[j]));
                    prt("\t mov\t %%rbx, %%%s\n", regs[j]);
                }
            }
            for(j = fargs->len-1; j >= 6; j--) {
                var_st *var = fargs->elems[j];
                if(var->value) {
                    prt("\t push\t %s\n", v2a(var));
                }
                else{
                    prt("\t mov\t %s, %%ebx\n", v2a(fargs->elems[j]));
                    prt("\t push\t %%rbx\n");
                }
            }
            prt("\t call\t%s\n", func->name);
            prt("\t mov\t%%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_RETURN) {
            if(f->ret)
                prt("\t mov\t %s, %%eax\n", v2a(f->ret));
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
            prt("\t cmpl\t $1, %s\n", v2a(args[0]));
            prt("\t je\t .%s\n", name_label(args[1]));
            //printf("cjmp %s %s", ldd(args[0]), name_label(args[1]));
        }
        else if(inst->op == IR_LT) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t cmp\t %s, %%edi\n", v2a(y));
            prt("\t setl\t %%al\n");
            prt("\t movzx\t %%al, %%eax\n");
            prt("\t mov\t %%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_LE) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t cmp\t %s, %%edi\n", v2a(y));
            prt("\t setle\t %%al\n");
            prt("\t movzx\t %%al, %%eax\n");
            prt("\t mov\t %%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_EQ) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t cmp\t %s, %%edi\n", v2a(y));
            prt("\t sete\t %%al\n");
            prt("\t movzx\t %%al, %%eax\n");
            prt("\t mov\t %%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_GT) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t cmp\t %s, %%edi\n", v2a(y));
            prt("\t setg\t %%al\n");
            prt("\t movzx\t %%al, %%eax\n");
            prt("\t mov\t %%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_GE) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t cmp\t %s, %%edi\n", v2a(y));
            prt("\t setge\t %%al\n");
            prt("\t movzx\t %%al, %%eax\n");
            prt("\t mov\t %%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_NEQ) {
            var_st *r = args[0], *x = args[1], *y = args[2];
            prt("\t mov\t %s, %%edi\n", v2a(x));
            prt("\t cmp\t %s, %%edi\n", v2a(y));
            prt("\t setne\t %%al\n");
            prt("\t movzx\t %%al, %%eax\n");
            prt("\t mov\t %%eax, %d(%%rbp)\n", ldd(r));
        }
        else if(inst->op == IR_INC) {
            var_st *v = args[0];
            prt("\t incl \t %d(%%rbp)\n", ldd(v));
        }
        else if(inst->op == IR_DEC) {
            var_st *v = args[0];
            prt("\t decl \t %d(%%rbp)\n", ldd(v));
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
    for(i = 0; i < funcs->len; i++)
        gen_func(funcs->elems[i]);
}

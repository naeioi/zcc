/* gen-ubuntu-x64.c. Assembly generator for ubuntu x64. 
 * link corresponding gen-x.c for different target platform.
 */
#include "zcc.h"
#include <string.h>
#include <stdio.h>

static FILE *fp;

#define pp(op)   fprintf(fp, #op "\t")
#define prt(...) fprintf(fp, __VA_ARGS__)
#define endl     fprintf("\n")

static void gen_global(func_st* f) {
    /* TODO: support global variable */
}

static void gen_func(func_st *f) {
    prt("\t.globl\t%s\n", f->name);
    prt("\t.type\t%s, @function\n", f->name);
    prt("%s:\n", f->name);
    prt("\tpushq\t%%rbp\n");
    prt("\tmovq\t%%rsp, %%rbp\n");
    
    
    int rbytes = 0, i;
    //for(i = 0; i < )
}

void gen_assembly(FILE *fp_) {
    list_st *funcs = context.funcs;
    int i;
    fp = fp_;
    gen_global(wrap_func);
    for(i = 0; i < funcs->len; i++)
        gen_func(funcs->elems[i]);
}
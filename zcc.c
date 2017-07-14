/***
 * ZCC - a study purpose compiler for C programming language
 * By keren. naeioi@hotmail.com
 */

#include "zcc.h"
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

/* =---- Others ----= */

void init(int argc, char **argv) {
    lex_init();
}

void test_lex(const char *filename) {
    lex_load_file(filename);
    while(1) {
        int n = lex_next();
        if(n != 0) return;
        lex_print_token(&lex_token);
    }
}

void test_binary(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    prs_expr();
}

void test_stmt(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    prs_stmt();
}

void test_decl(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    prs_decl();
}

void test_decls(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    prs_decls();
}

void test_ir(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    sym_init();
    prs_decls();
    
    fprintf(stderr, "Parse done.\n");
    
    list_st *funcs = context.funcs;
    int i = 0;
    fprintf(stderr, "Read %d funcs.\n", funcs->len);
    for(; i < funcs->len; i++) {
        printf("\n");
        gen_print_func_ir(funcs->elems[i]);
    }
}

void test_asm(char *filename) {
    lex_load_file(filename);
    lex_next();
    
    prs_init();
    sym_init();
    prs_decls();
    
    fprintf(stderr, "Parse done.\n");
    
    list_st *funcs = context.funcs;
    fprintf(stderr, "Read %d funcs.\n", funcs->len);
    
    gen_assembly(stdout);
}

void to_asm(char *infile, char *outfile) {
    lex_load_file(infile);
    lex_next();
    
    prs_init();
    sym_init();
    prs_decls();
    
    fprintf(stderr, "Parse done.\n");
    
    list_st *funcs = context.funcs;
    fprintf(stderr, "Read %d funcs.\n", funcs->len);
    
    FILE *fp = fopen(outfile, "w");
    gen_assembly(fp);
}

int main(int argc, char **argv)
{
    init(argc, argv);
    if(argc == 3 && strcmp("-l", argv[1]) == 0)
        test_lex(argv[2]);
    if(argc == 3 && strcmp("-b", argv[1]) == 0)
        test_binary(argv[2]);
    if(argc == 3 && strcmp("-s", argv[1]) == 0)
        test_stmt(argv[2]);
    if(argc == 3 && strcmp("-d", argv[1]) == 0)
        test_decl(argv[2]);
    if(argc == 3 && strcmp("-ds", argv[1]) == 0)
        test_decls(argv[2]);
    if(argc == 3 && strcmp("-ir", argv[1]) == 0)
        test_ir(argv[2]);
    if(argc == 3 && strcmp("-a" , argv[1]) == 0)
        test_asm(argv[2]);
    if(argc == 5 && strcmp("-a" , argv[1]) == 0 && strcmp("-o", argv[3]) == 0) {
        to_asm(argv[2], argv[4]);
    }
}   
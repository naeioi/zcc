/* utility.c */

#include "zcc.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

void fexit(const char *format, ...) {
    puts(format);
    printf("\n");
    exit(0);
}

static int isvar[][3] = {
    /* IR_ADD */    { 1, 1, 1 },
    /* IR_SUB */    { 1, 1, 1 },
    /* IR_MUL */    { 1, 1, 1 },
    /* IR_DIV */    { 1, 1, 1 },
    /* IR_RETURN */ { 1, 0, 0 },
    /* IR_CALL */   { 1, 0, 0 },
    /* IR_ASSIGN */ { 1, 1, 0 },
    /* IR_LABEL */  { 0, 0, 0 },
    /* IR_JMP */    { 0, 0, 0 },
    /* IR_CJMP */   { 1, 0, 0 },
    /* IR_LT */     { 1, 1, 1 },
    /* IR_LE */     { 1, 1, 1 },
    /* IR_EQ */     { 1, 1, 1 },
    /* IR_GT */     { 1, 1, 1 },
    /* IR_GE */     { 1, 1, 1 },
    /* IR_NEQ */    { 1, 1, 1 },
    /* IR_INC */    { 1, 0, 0 },
    /* IR_DEC */    { 1, 0, 0 },
    /* IR_IND */    { 1, 1, 1 },
    /* IR_OFFSET */ { 1, 1, 0 }
};

/* duplicate temp var. imm var not included */
var_st *dup_arg(ir_op_en op, int i, var_st *var) {
    if(!isvar[op][i]) return var;
    return dup_temp_var(var);
}

var_st *dup_temp_var(var_st *var) {
    if(var->lvalue || var->value) return var;
    var_st *nvar = malloc(sizeof(var_st));
    memcpy(nvar, var, sizeof(var_st));
    return nvar;
}

char* dup_str(char* s) {
    if(!s) return NULL;
    int len = strlen(s) + 1;
    char *t = malloc(len);
    strcpy(t, s);
    return t;
}

value_un *dup_value(token_st *tk) {
    value_un *r = malloc(sizeof(value_un));
    if(tk->tk_class == TK_CONST_INT)
        memcpy(r, tk->value, sizeof(value_un));
    else if(tk->tk_class == TK_CONST_STRING) {
        r->s = dup_str(tk->tk_str);
    }
    return r;
}

list_st* make_list() {
    #define LIST_INIT_SIZE 10
    list_st *list   = malloc(sizeof(list_st));
    list->room      = LIST_INIT_SIZE;
    list->len       = 0;
    list->elems     = malloc(sizeof(void*) * LIST_INIT_SIZE);
    return list;
}

void* list_append(list_st* list, void* elem) {
    if(list->len >= list->room) {
        list->room *= 2;
        list->elems = realloc(list->elems, list->room * sizeof(void*));
    }
    list->elems[list->len++] = elem;
    return NULL;
}

void* list_pop(list_st* list) {
    assert(list->len > 0);
    return list->elems[--list->len];
}

int list_isempty(list_st* list) {
    return list->len == 0;
}

int list_index(list_st* list, void* elem) {
    int i = 0;
    for(; i < list->len; i++)
        if(list->elems[i] == elem)
            return i;
    return -1;
}
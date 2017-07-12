/* utility.c */

#include "zcc.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void fexit(const char *format, ...) {
    puts(format);
    printf("\n");
    exit(0);
}

char* dup_str(char* s) {
    int len = strlen(s) + 1;
    char *t = malloc(len);
    strcpy(t, s);
    return t;
}

value_st *dup_value(value_st *val) {
    value_st *r = malloc(sizeof(value_st));
    memcpy(r, val, sizeof(value_st));
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
        realloc(list->elemes, list->room);
        list->elems[list->len++] = elem;
    }
    return NULL;
}

int list_index(list_st* list, void* elem) {
    int i = 0;
    for(; i < list->len; i++)
        if(list->elems[i] == elem)
            return i;
    return -1;
}
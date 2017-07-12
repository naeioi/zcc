/* utility.c */

#include "zcc.h"
#include <stdio.h>
#include <stdlib.h>

void fexit(const char *format, ...) {
    puts(format);
    printf("\n");
    exit(0);
}

list_st* make_list() {
    #define LIST_INIT_SIZE 10
    list_st *list   = malloc(sizeof(list_st));
    list->room      = LIST_INIT_SIZE;
    list->len       = 0;
    list->elems     = malloc(sizeof(void*) * LIST_INIT_SIZE);
    return list;
}

void* list_append(list_st*, void* elem) {
    /* TODO */
    return NULL;
}
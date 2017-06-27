#ifndef ASSO_LEFT
#define ASSO_L 0
#define ASSO_R 1
#endif

/* 2 chars operators */
/* - NAME STRING ASSOCIATIVE PRECEDENCE - */
yy(TK_OP_DEREF,     "->",	ASSO_L,     0)
yy(TK_OP_INC,       "++",	ASSO_L,     14)
yy(TK_OP_DEC,       "--",	ASSO_L,     14)
yy(TK_OP_LAND,      "&&",	ASSO_L,     5) /* V-- binary ops starts */
yy(TK_OP_LOR,       "||",	ASSO_L,     4)
yy(TK_OP_EQ,        "==",	ASSO_L,     9)
yy(TK_OP_NEQ,       "!=",	ASSO_L,     9)
yy(TK_OP_LE,        "<=",	ASSO_L,     10)
yy(TK_OP_GE,        ">=",	ASSO_L,     10)
/* single char operators */
xx(TK_OP_ADD,       '+',	ASSO_L,     12)
xx(TK_OP_DEL,       '-',	ASSO_L,     12)
xx(TK_OP_MUL,       '*',	ASSO_L,     13)
xx(TK_OP_DIV,       '/',	ASSO_L,     13)
xx(TK_OP_BAND,      '&',	ASSO_L,     8)
xx(TK_OP_BXOR,      '^',	ASSO_L,     7)
xx(TK_OP_BOR,       '|',	ASSO_L,     6)
xx(TK_OP_MOD,       '%',	ASSO_L,     13)
xx(TK_OP_LT,        '<',	ASSO_L,     10)
xx(TK_OP_GT,        '>',	ASSO_L,     10) /* ^-- binary ops ends */
xx(TK_OP_LNOT,      '!',	ASSO_L,     14)
xx(TK_OP_BNOT,      '~',	ASSO_L,     14)
xx(TK_OP_REF,       '.',	ASSO_L,     0)

xx(TK_OP_ASSIGN,    '=',	ASSO_R,     2)
yy(TK_OP_ASSIGN_ADD,    "+=",   ASSO_R,     2)
yy(TK_OP_ASSIGN_DEL,    "-=",   ASSO_R,     2)
yy(TK_OP_ASSIGN_MUL,    "*=",   ASSO_R,     2)
yy(TK_OP_ASSIGN_DIV,    "/=",   ASSO_R,     2)
yy(TK_OP_ASSIGN_MOD,    "%=",   ASSO_R,     2)
/// Not support now. For lexer doesn't supports op of more than 2 chars
//yy(TK_OP_ASSIGN,    "<<=",   ASSO_R,     2)
//yy(TK_OP_ASSIGN,    ">>=",   ASSO_R,     2)
yy(TK_OP_ASSIGN_BAND,    "&=",   ASSO_R,     2)
yy(TK_OP_ASSIGN_BXOR,    "^=",   ASSO_R,     2)
yy(TK_OP_ASSIGN_BOR,     "|=",   ASSO_R,     2)

/* delimiers */
zz(TK_DELIMITER,    '[')
zz(TK_DELIMITER,    ']')
zz(TK_DELIMITER,    '(')
zz(TK_DELIMITER,    ')')
zz(TK_DELIMITER,    '{')
zz(TK_DELIMITER,    '}')
zz(TK_DELIMITER,    ';')
zz(TK_DELIMITER,    ',')
zz(TK_DELIMITER,    '?')
zz(TK_DELIMITER,    ':')

#ifndef BINARY_OP_BEGIN
#define BINARY_OP_BEGIN     TK_OP_LAND
#define BINARY_OP_END       TK_OP_GT
#endif

#ifndef ASSIGN_OP_BEGIN
#define ASSIGN_OP_BEGIN     TK_OP_ASSIGN
#define ASSIGN_OP_END       TK_OP_ASSIGN_BOR
#endif
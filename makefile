CC = gcc
CFLAGS = -Wall -g

all: zcc
    
%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS)
    
zcc: zcc.o lex.o parse.o sym.o utility.o
	$(CC) $^ -o $@ $(CFLAGS)

.PHONY: clean

clean:
	rm -f zcc *.o
CC = gcc
CFLAGS = -Wall -g

all: zcc
    
%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS)
    
zcc: zcc.o
	$(CC) $^ -o $@ $(CFLAGS)

.PHONY: clean

clean:
	rm -f zcc *.o
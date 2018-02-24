# Custom Makefile to build and run primpoly

# define the C compiler to use
CC = gcc

# define any compile-time flags
CFLAGS = -Wall -std=gnu11
LIBS += -lm

# define the C source files
SRCS = ppArith.c ppFactor.c ppHelperFunc.c ppIO.c ppOrder.c ppPolyArith.c Primpoly.c

# define the C object files
OBJS = ${SRCS:.c=.o}

# define the executable file
EXE = primpoly.o

# raw primitive polynomials dump file
RAW = ../raw_primitive_polynomials.txt

.PHONY: run
run:
	./${EXE} -a 2 ${n}

.PHONY: build
build: ${EXE}
	@echo "Program compiled successfully"

${EXE}: ${OBJS}
	${CC} ${CFLAGS} -o ${EXE} ${OBJS} ${LIBS}

.c.o:
	${CC} ${CFLAGS} -c $< -o $@


.PHONY: val
val:
	@valgrind ./${EXE} ${INPUT}


.PHONY: clean
clean:
	# clean out cache and temporary files
	@find . \( -name "*.o" -o -name ${EXE} \) -type f -delete
	@> ${RAW}

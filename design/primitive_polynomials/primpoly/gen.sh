#!/usr/bin/env bash

# Helper script to automate generation of list of primitive polynomials of
# degrees 2 to 15.
set -o errexit

MINDEG=2  # minimum degree
MAXDEG=15  # maximum degree

# output of executable
DUMP="../primitive_polynomials_dump.txt"

# raw primitive polynomials dump file
RAW="../raw_primitive_polynomials.txt"

for (( n = $MINDEG; n <= $MAXDEG; n++))
do
    make run n=$n > ${DUMP};
    cat ${DUMP} | grep -E "^ (\+|x)" | sed 's/ x/x/g' | sed 's/ ^ /^/g' >> ${RAW};
done

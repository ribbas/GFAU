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

FINALOUT="../primitivebcd15.txt"

# clean up cache and old data
make clean
make build

# loop through the degrees to generate their primitve polynomials
for (( n = $MINDEG; n <= $MAXDEG; n++))
do
    echo "Generating primitive polynomials for n="$n;
    make run n=$n > ${DUMP};
    cat ${DUMP} | grep -E "^ (\+|x)" | sed 's/ x/x/g' | sed 's/ ^ /^/g' >> ${RAW};
done

# convert raw output to bit vectors
echo -n "Converting polynomial strings to binary-coded decimals... "
python ../polytobcd.py $MAXDEG $RAW > FINALOUT
echo "Done"
echo "Polynomials generated:" $(cat $FINALOUT | wc -l)

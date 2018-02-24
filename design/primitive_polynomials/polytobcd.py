#!/usr/bin/env python
# -*- coding: utf-8 -*-

if __name__ == "__main__":

    from sys import argv

    max_deg = int(argv[1])
    with open(argv[2]) as poly_file:

        poly_lines = [
            line.replace("\n", "") for line in poly_file.read().split(" + 1")
        ][:-1]

        for line in poly_lines:

            bit_vect = ["1"] + ["0"] * max_deg
            polynomial = line.replace("x^", "").split(" + ")
            polynomial = ["1" if line == "x" else line for line in polynomial]
            polynomial = [int(i) for i in polynomial]

            if polynomial[0] > max_deg:
                break

            for term in polynomial:
                bit_vect[term] = "1"

            print "".join(bit_vect[::-1])

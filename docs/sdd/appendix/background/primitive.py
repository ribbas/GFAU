#!/usr/bin/env python
# -*- coding: utf-8 -*-

if __name__ == "__main__":

    max_deg = 15
    with open("primitive_polynomials_GF2.txt") as poly_file:
        for line in poly_file:
            bit_vect = ["1"] + ["0"] * max_deg
            polynomial = line[:-3].replace("D^", "").split("+")
            polynomial = [int(i) for i in polynomial]
            if polynomial[0] > max_deg:
                break

            for term in polynomial:
                bit_vect[term] = "1"
            print "".join(bit_vect[::-1])

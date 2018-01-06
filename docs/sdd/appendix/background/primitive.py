#!/usr/bin/env python
# -*- coding: utf-8 -*-

if __name__ == "__main__":

    max_deg = 15
    with open("primitive_polynomials_GF2.txt") as poly_file:
        for line in poly_file:
            bit_vect = ["0"] * max_deg + ["1"]
            polynomial = line.replace("\n", "")[
                :-4].replace(" + ", "").split("x^")[1:]
            polynomial = [int(i) for i in polynomial]
            if polynomial[0] > max_deg:
                break

            for term in polynomial:
                bit_vect[int(term)] = "1"
            print "".join(bit_vect)

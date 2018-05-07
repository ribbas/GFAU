#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import, print_function, unicode_literals

import argparse
import math
import os
from pprint import pprint

from modstr import GLOB_STR, INDICES_STR, VARMASK_STR

try:
    input = raw_input
    range = xrange
except NameError:
    pass


def find_file(name):
    result = []
    for root, dirs, files in os.walk(".."):
        if name in files:
            result.append(os.path.join(root, name))
    return result


def parse_args(args):

    deg = int(args["degree"])
    ceillgn = int(math.ceil(math.log(deg, 2)))
    ceillgn1 = ceillgn - 1

    with open(args["glob"], "w") as glob_file:
        glob_file.write(GLOB_STR.format(
            deg=deg, ceillgn=ceillgn, ceillgn1=ceillgn1))

    varmask_enc = ""
    varmask_line = "\"{vec}\" when (poly_bcd({bit}) = '1') else\n"

    for index in range(deg, 1, -1):

        if index == deg:
            varmask_enc += varmask_line.format(
                vec="0" * (deg - index + 1) + "1" * index, bit=str(index)
            )

        else:
            varmask_enc += "\t\t" + varmask_line.format(
                vec="0" * (deg - index + 1) + "1" * index, bit=str(index)
            )

    with open(args["mask"], "w") as varmask_file:
        varmask_file.write(VARMASK_STR.format(varmask_enc))

    indices_enc = ""
    indices_fmt = "{:0%db}" % (ceillgn + 1)
    indices_line = "\"{vec}\" when (poly_bcd({bit}) = '1') else\n"

    for index in range(deg, 1, -1):

        if index == deg:
            indices_enc += indices_line.format(
                vec=indices_fmt.format(index),
                bit=str(index)
            )

        else:
            indices_enc += "\t\t" + indices_line.format(
                vec=indices_fmt.format(index),
                bit=str(index)
            )

    with open(args["indices"], "w") as indices_file:
        indices_file.write(INDICES_STR.format(indices_enc))


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description="Dynamically generate priority encoders and data bus size",
        add_help=False
    )

    parser.add_argument("-h", "--help", action="help",
                        default=argparse.SUPPRESS,
                        help="| Show this help message and exit")

    parser.add_argument("--degree", "-d", default=4, metavar="N",
                        type=int, help="| Highest number of degree")

    parser.add_argument("--glob", "-g", default="", metavar="PATH",
                        help="| Path of 'glob.vhd'")

    parser.add_argument("--indices", "-i", default="", metavar="PATH",
                        help="| Path of 'indices.vhd'")

    parser.add_argument("--mask", "-m", default="", metavar="PATH",
                        help="| Path of 'varmask.vhd'")

    # parse arguments to pass into function
    args = parser.parse_args()

    if (not os.path.isfile(args.glob)):
        glob_file = find_file("glob.vhd")
        if (len(glob_file) > 1):
            print("Multiple 'glob.vhd' found")
            print("'glob.vhd' files found:")
            pprint(glob_file)
        else:
            print("Picking 'glob.vhd' file found at '{0}'".format(glob_file[0]))
            args.__dict__["glob"] = glob_file[0]

    if (not os.path.isfile(args.indices)):
        indices_file = find_file("indices.vhd")
        if (len(indices_file) > 1):
            print("Multiple 'indices.vhd' found")
            print("'indices.vhd' files found:")
            pprint(indices_file)
        else:
            print("Picking 'indices.vhd' file found at '{0}'".format(
                indices_file[0]))
            args.__dict__["indices"] = indices_file[0]

    if (not os.path.isfile(args.mask)):
        varmask_file = find_file("varmask.vhd")
        if (len(varmask_file) > 1):
            print("Multiple 'varmask.vhd' found")
            print("'varmask.vhd' files found:")
            pprint(varmask_file)
        else:
            print("Picking 'varmask.vhd' file found at '{0}'".format(
                varmask_file[0]))
            args.__dict__["mask"] = varmask_file[0]

    print("\x1b[1;31;40mParameters chosen:\x1b[0m")
    pprint(args.__dict__)
    init_gen = input("Continue? (y/n): ")
    if (init_gen.lower() == 'y'):
        print("Generating modules...", end="")
        parse_args(args.__dict__)
        print("Done")
    else:
        print("Please provide the full path to all files")
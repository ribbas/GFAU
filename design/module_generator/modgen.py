#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import, print_function, unicode_literals

import argparse
import math
import os
from pprint import pprint

from modstr import GLOB_STR, VARMASK_STR

try:
    input = raw_input
    range = xrange
except NameError:
    pass

BASE_DIR = os.getcwd()
print(BASE_DIR)


def find_file(file_name):
    result = []
    for root, dirs, files in os.walk(BASE_DIR):
        if file_name in files:
            result.append(os.path.join(root, file_name))
    return result


def assign_path(args, file_name):

    if (not os.path.isfile(args[file_name])):
        found_files = find_file("{0}.vhd".format(file_name))
        if (len(found_files) == 1):
            print("Picking '{0}.vhd' file found at"
                  " \x1b[1;32;40m'{1}'\x1b[0m".format(
                      file_name, found_files[0]))
            args[file_name] = found_files[0]
            return False

        elif (len(found_files) > 1):
            print("Multiple '{0}.vhd' found:".format(file_name))
            pprint(found_files)

        else:
            print("No '{0}.vhd' files found".format(file_name))

        return True


def write_glob(deg, ceillgn, ceillgn1):

    with open(args["glob"], "w") as glob_file:
        glob_file.write(GLOB_STR.format(
            deg=deg, ceillgn=ceillgn, ceillgn1=ceillgn1))


def write_varmask(deg):

    varmask_enc = ""
    varmask_line = "\"{vec}\" when (poly_bcd({bit}) = '1') else\n"

    for index in range(deg, 0, -1):
        case_str = varmask_line.format(
            vec="0" * (deg - index) + "1" * (index + 1), bit=str(index)
        )

        if index != deg:
            varmask_enc += " " * 12 + case_str

        else:
            varmask_enc += case_str

    print(varmask_enc)

    with open(args["varmask"], "w") as varmask_file:
        varmask_file.write(VARMASK_STR.format(varmask_enc))


def parse_args(args):

    deg = int(args["degree"])
    ceillgn = int(math.ceil(math.log(deg, 2)))
    ceillgn1 = int(math.ceil(math.log(deg - 1, 2)))

    write_glob(deg=deg, ceillgn=ceillgn, ceillgn1=ceillgn1)

    write_varmask(deg=deg)


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

    parser.add_argument("--varmask", "-v", default="", metavar="PATH",
                        help="| Path of 'varmask.vhd'")

    # parse arguments to pass into function
    args = parser.parse_args().__dict__
    ambiguous = assign_path(args, "glob")
    ambiguous = assign_path(args, "varmask")

    if (not ambiguous):

        print("\nParameters chosen:")
        pprint(args)
        init_gen = input("Continue? (y/n): ")
        if (init_gen.lower() == 'y'):
            args["degree"] -= 1
            print("Generating modules...", end="")
            parse_args(args)
            print("Done")
        else:
            print("\x1b[1;31;40mModule generation canceled\x1b[0m")

    else:

        print("\x1b[1;31;40mPlease specify the path to the input files\x1b[0m")

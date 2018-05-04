#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import, print_function, unicode_literals

import argparse
import fileinput
import math
import os
from pprint import pprint
try:
    input = raw_input
except NameError:
    pass

VARMASK_STR = \
    ("library ieee;\n"
     "    use ieee.std_logic_1164.all;\n"
     "    use ieee.numeric_std.all;\n"
     "library work;\n"
     "    use work.glob.all;\n\n"
     "entity varmask is\n"
     "    generic(\n"
     "        n           : positive := DEGREE\n"
     "    );\n"
     "    port(\n"
     "        poly_bcd    : in std_logic_vector(n downto 2);  -- BCD polynomial\n"
     "        mask        : out std_logic_vector(n downto 0) := (others => '0')\n"
     "   );\n"
     "end varmask;\n\n"
     "architecture behavioral of varmask is\n"
     "begin\n\n"
     "    mask <= {0}"
     "\t\tDCAREVEC;\n\n"
     "end behavioral;\n")

INDICES_STR = \
    ("library ieee;\n"
     "    use ieee.std_logic_1164.all;\n"
     "    use ieee.numeric_std.all;\n"
     "library work;\n"
     "    use work.glob.all;\n\n"
     "entity indices is\n"
     "    generic(\n"
     "        n           : positive := DEGREE;\n"
     "        clgn        : positive := CEILLGN;  -- ceil(log2(n))\n"
     "        clgn1       : positive := CEILLGN1   -- ceil(log2(n - 1))\n"
     "    );\n"
     "    port(\n"
     "        poly_bcd    : in std_logic_vector(n downto 2);  -- BCD polynomial\n"
     "        size        : out std_logic_vector(clgn downto 0);  -- size\n"
     "        msb         : out std_logic_vector(clgn1 downto 0)  -- msb\n"
     "    );\n"
     "end indices;\n\n"
     "architecture behavioral of indices is\n\n"
     "    signal prio_enc : std_logic_vector(clgn downto 0) := (others => '-');\n\n"
     "begin\n\n"
     "    prio_enc <= {0}"
     "\t\tDCAREVEC(clgn downto 0);\n\n"
     "    size <= prio_enc;\n"
     "    msb <= std_logic_vector(unsigned(prio_enc(clgn1 downto 0)) - 1);\n\n"
     "end behavioral;\n")


def find_file(name):
    result = []
    for root, dirs, files in os.walk("."):
        if name in files:
            result.append(os.path.join(root, name))
    return result


def parse_args(args):

    deg = int(args["degree"])
    ceillgn = int(math.ceil(math.log(deg, 2)))
    ceillgn1 = int(math.ceil(math.log(deg - 1, 2)))

    for line in fileinput.input(args["glob"], inplace=True):

        if ("constant DEGREE" in line):
            print("\tconstant DEGREE : positive := {0};".format(deg))

        elif ("constant CEILLGN " in line):
            print("\tconstant CEILLGN : positive := {0};".format(ceillgn))

        elif ("constant CEILLGN1" in line):
            print("\tconstant CEILLGN1 : positive := {0};".format(ceillgn1))

        else:
            print(line, end="")

    varmask_enc = ""
    varmask_line = "\"{vec}\" when (poly_bcd({bit}) = '1') else\n"

    for index in xrange(deg, 1, -1):

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

    print(ceillgn)
    indices_enc = ""
    indices_fmt = "{:0%db}" % (ceillgn + 1)
    print(indices_fmt)
    indices_line = "\"{vec}\" when (poly_bcd({bit}) = '1') else\n"

    for index in xrange(deg, 1, -1):

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
        print("Generating modules...")
        parse_args(args.__dict__)
    else:
        print("Please provide the full path to all files")

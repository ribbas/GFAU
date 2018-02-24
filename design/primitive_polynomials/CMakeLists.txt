cmake_minimum_required(VERSION 3.9)
project(primitive_polynomials)

set(CMAKE_CXX_STANDARD 11)

add_executable(primitive_polynomials
        isprimitive.c
        primitive15.txt)

cmake_minimum_required(VERSION 3.9)
project(primpoly)

set(CMAKE_C_STANDARD 11)

set(SOURCE_FILES ppArith.c ppFactor.c ppHelperFunc.c ppIO.c ppOrder.c
        ppPolyArith.c Primpoly.c Primpoly.h)

add_executable(primpoly ${SOURCE_FILES})
target_link_libraries(primpoly m)

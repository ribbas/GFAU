/*
 * isprimitive.c
 * Galois Field Arithmetic Unit: External IO Library
 * Sabbir Ahmed
 *
 * Checks if an n-degree polynomial is primitive.
 *
 * Usage:
 *      is_primitive("primitive15.txt", "1111111011111111", 16)
 *
 * Copyright (c) 2018 Sabbir Ahmed
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*
 * Reads single line of file.
 *
 * Inputs:
 *      fstream <FILE*> : pointer to file object
 *
 * Outputs:
 *      <char*> line of file
 *
 */
char *read_line(FILE *fstream, int buf_size) {

    char *buffer;
    char *tmp;
    int read_chars = 0;
    char *line = malloc(buf_size);

    if (!line) {
        return NULL;
    }

    buffer = line;

    while (fgets(buffer, buf_size - read_chars, fstream)) {

        read_chars = strlen(line);

        if (line[read_chars - 1] == '\n') {

            line[read_chars - 1] = '\0';

            return line;

        } else {

            buf_size = 2 * buf_size;
            tmp = realloc(line, buf_size);

            if (tmp) {

                line = tmp;
                buffer = line + read_chars;

            } else {

                free(line);
                line = NULL;

                return NULL;

            }
        }
    }

    free(buffer);
    buffer = NULL;

    return NULL;

}

/*
 * Compares input polynomial with list of primitive polynomials.
 *
 * Inputs:
 *
 *      file_name <char*> : path of file containing all n-degree primitive
 *                          polynomials
 *      polynomial <char*> : BCD polynomial
 *      num_bits <int> : number of bits representing the BCD polynomial
 *
 * Outputs:
 *
 *      <int> 1 if polynomial is primitive, 0 otherwise
 *
 */
int is_primitive(char *file_name, char *polynomial, int num_bits) {

    FILE *fstream;
    char *line;
    int found = 0;

    fstream = fopen(file_name, "r");

    if (fstream) {
        while (line = read_line(fstream, num_bits + 1)) {

            // if polynomial is found
            if (strstr(line, polynomial)) {

                found = 1;
                free(line);
                line = NULL;
                break;

            }

            free(line);
            line = NULL;

        }
    }

    fclose(fstream);

    return found;

}

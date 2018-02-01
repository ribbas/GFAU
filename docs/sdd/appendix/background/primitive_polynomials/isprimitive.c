#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *read_line(FILE *fin) {

    char *buffer;
    char *tmp;
    int read_chars = 0;
    int buf_size = 17;  // 16-bit polynomial
    char *line = malloc(buf_size);

    if (!line) {
        return NULL;
    }

    buffer = line;

    while (fgets(buffer, buf_size - read_chars, fin)) {

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


int is_primitive(char *file_name, char *polynomial) {

    FILE *fin;
    char *line;
    char found = 0;

    fin = fopen(file_name, "r");

    if (fin) {
        while (line = read_line(fin)) {

            if (strstr(line, polynomial)) {

                found = 1;
                free(line);
                break;

            }

            free(line);

        }
    }

    fclose(fin);

    return found;

}


int main() {

    printf("%d", is_primitive("primitive15.txt", "1111111011111111"));
    return EXIT_SUCCESS;

}
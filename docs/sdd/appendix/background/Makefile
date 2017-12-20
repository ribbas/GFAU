# Makefile to ease trivial tasks for the project

all: convert


.PHONY: convert convert1 convert2
convert: convert1 convert2
convert1 convert2:
	# convert LaTex file to PDF
	@pdflatex background.tex
	@bibtex background.aux


.PHONY: clean
clean:
	# clean out cache and temporary files
	@find . \( -name "*.aux" -o -name "*.log" -o -name "*.blg" \
		-o -name "*.bbl" \) -type f -delete

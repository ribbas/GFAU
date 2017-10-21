# Makefile to handle compilation and testing of VHDL modules


.PHONY: compile
compile:
	@ghdl -a ${mod}


.PHONY: clean
clean:
	# clean out cache and temporary files
	@find . \( -name "*.a" -o -name "*.o" -o -name "*.cf" \) -type f -delete

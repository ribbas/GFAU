# Makefile to help clean and maintain project


.PHONY: clean-proj
clean-proj:
	@find xilinx_tb \( ! -name "*.xise" ! -name "*.ucf" ! -name "*.v" ! -name \
		"*.bit" ! -name "*.log" \) -type f -delete
	@find xilinx_tb -depth -type d -empty -delete

# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: Luke_Stewart.pdf all clean

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: Luke_Stewart.pdf

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

Luke_Stewart.pdf: src/Luke_Stewart.tex
	pdflatex -interaction=nonstopmode src/Luke_Stewart.tex && \
	pdflatex -interaction=nonstopmode src/Luke_Stewart.tex && \
	rm *.aux *.out *.log && \
	mv Luke_Stewart.pdf output && \
	pandoc -s src/Luke_Stewart.tex -o output/Luke_Stewart.md

# TEXINPUTS=.//:${TEXINPUTS} lualatex -interaction=nonstopmode src/Luke_Stewart.tex && \
# 	TEXINPUTS=.//:${TEXINPUTS} lualatex -interaction=nonstopmode src/Luke_Stewart.tex && \
# 	rm *.aux *.out *.log && \
# 	mv Luke_Stewart.pdf output

clean:
	rm *.aux *.out *.log output/Luke_Stewart.pdf output/Luke_Stewart.md 2>/dev/null
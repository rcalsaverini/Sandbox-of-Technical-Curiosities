# Makefile for Mathematical Scrapyard LaTeX book
# Uses LuaLaTeX via latexmk for reliable compilation

MAIN = main.tex
PDF = main.pdf

.PHONY: all clean clean-all help watch

# Default target: compile PDF using LuaLaTeX
all: $(PDF)

# Compile PDF with latexmk (uses LuaLaTeX by default based on file extension or config)
$(PDF): $(MAIN) setup.sty content/*.tex nontext/*.tex
	latexmk -lualatex -interaction=nonstopmode $(MAIN)

# One-time compilation with LuaLaTeX (without latexmk dependency tracking)
lualatex:
	lualatex -interaction=nonstopmode $(MAIN)

# Clean auxiliary files (keep PDF)
clean:
	latexmk -c

# Clean all generated files including PDF
clean-all:
	latexmk -C

# Open PDF with default viewer (Linux)
view: $(PDF)
	xdg-open $(PDF) 2>/dev/null || open $(PDF) 2>/dev/null || echo "Could not open PDF"

# Watch for changes and recompile automatically
watch:
	latexmk -lualatex -pvc -interaction=nonstopmode $(MAIN)

# Show help
help:
	@echo "Mathematical Scrapyard LaTeX Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make           - Compile PDF using latexmk with LuaLaTeX (default)"
	@echo "  make lualatex  - One-time compilation with LuaLaTeX"
	@echo "  make clean     - Remove auxiliary files (keep PDF)"
	@echo "  make clean-all - Remove all generated files including PDF"
	@echo "  make view      - Open PDF with default viewer"
	@echo "  make watch     - Watch for changes and recompile automatically"
	@echo "  make help      - Show this help"
	@echo ""
	@echo "Dependencies: latexmk, lualatex, and standard LaTeX packages"
	@echo "The project uses LuaLaTeX (not PDFLaTeX or XeLaTeX)"
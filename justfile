# justfile for Mathematical Scrapyard LaTeX book
# Uses tectonic for modern, reliable LaTeX compilation

set shell := ["bash", "-cu"]

# Default recipe: compile PDF using tectonic
@default: build

# Compile PDF with tectonic
build:
    tectonic main.tex

# Watch for changes and recompile automatically
watch:
    find . -name "*.tex" -o -name "*.sty" | entr tectonic main.tex

# Clean auxiliary files (keep PDF)
clean:
    rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk main.synctex.gz

# Clean all generated files including PDF
clean-all: clean
    rm -f main.pdf

# Open PDF with default viewer
view: build
    xdg-open main.pdf 2>/dev/null || open main.pdf 2>/dev/null || echo "Could not open PDF"

# Show available recipes
help:
    @echo "Mathematical Scrapyard LaTeX Build System"
    @echo ""
    @echo "Available recipes:"
    @echo "  just              - Compile PDF using tectonic (default)"
    @echo "  just watch        - Watch for changes and recompile automatically"
    @echo "  just clean        - Remove auxiliary files (keep PDF)"
    @echo "  just clean-all    - Remove all generated files including PDF"
    @echo "  just view         - Build and open PDF with default viewer"
    @echo "  just help         - Show this help message"
    @echo ""
    @echo "Dependencies: tectonic, just"
    @echo "The project uses tectonic (modern, self-contained TeX engine)"

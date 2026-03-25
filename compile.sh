#!/bin/bash
# Quick LaTeX compilation script

echo "📄 Compiling $1..."

# Clean previous auxiliary files (optional - uncomment if needed)
# rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg

# First pass
pdflatex -interaction=nonstopmode $1 > /dev/null 2>&1

# Bibliography
bibtex ${1%.*} > /dev/null 2>&1

# Second pass
pdflatex -interaction=nonstopmode $1 > /dev/null 2>&1

# Final pass (show output)
pdflatex -interaction=nonstopmode $1

echo "✅ Done! Output: ${1%.*}.pdf"
ls -lh ${1%.*}.pdf

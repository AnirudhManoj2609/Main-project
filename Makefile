# LaTeX Makefile
FILE = project_final

all: compile

compile:
	pdflatex $(FILE).tex
	bibtex $(FILE)
	pdflatex $(FILE).tex
	pdflatex $(FILE).tex

quick:
	pdflatex $(FILE).tex

clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.synctex.gz

view:
	evince $(FILE).pdf

watch:
	while true; do inotifywait -e modify $(FILE).tex; make compile; done

.PHONY: all compile quick clean view watch

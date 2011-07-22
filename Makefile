diplom:
	pdflatex diplom.tex

all: diplom bib

bib:
	bibtex diplom

clean: 
	rm -rf *.pdf *.log *.aux *.ilg *.log *.nlo *.nls *.bbl *.blg *.toc

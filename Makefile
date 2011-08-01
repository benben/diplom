all: diplom bib diplom

diplom:
	pdflatex diplom.tex

bib:
	bibtex diplom

clean: 
	rm -rf *.pdf *.log *.aux *.ilg *.log *.lof *.lot *.nlo *.nls *.bbl *.blg *.toc

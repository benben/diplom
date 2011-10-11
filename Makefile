diplom:
	pdflatex diplom.tex
	bibtex diplom
	pdflatex diplom.tex
	pdflatex diplom.tex

all: diplom
	gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=diplom_final.pdf -dBATCH diplom.pdf selbst.pdf

bib:
	bibtex diplom

clean: 
	rm -rf *.pdf *.log *.aux *.ilg *.log *.lof *.lot *.nlo *.nls *.bbl *.blg *.toc

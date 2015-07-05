#You can call:
#
# make		: will make the postscript version
# make pdf	: will make the pdf version
# make clean	: will clean up .aux .log .dvi .ps...
#
# Handles bibliography, handles LaTeX requests to rerun
# assumes bash

.PHONY=latexprocess figures

MAINFILE=diss

BIBFILE=phd
PDFLATEX=1


ifdef PDFLATEX
LATEX=pdflatex
PRIMTARGET=$(MAINFILE).pdf
else
LATEX=latex
PRIMTARGET=$(MAINFILE)2.ps
endif

all: $(PRIMTARGET)

DEPS=$(MAINFILE).tex figures 

frontreferences2.bbl: frontreferences.tex ProjectBibliography/projectbib.bib
	latex frontreferences.tex
	bibtex frontreferences
	cat frontreferences.bbl | perl -pe 's/bibitem/mybibitem/' | grep -v thebibliography > frontreferences2.bbl

secondfrontreferences2.bbl: secondfrontreferences.tex ProjectBibliography/projectbib.bib
	latex secondfrontreferences.tex
	bibtex secondfrontreferences
	cat secondfrontreferences.bbl | perl -pe 's/bibitem/mybibitem/' | grep -v 'Copyright AAAI' | grep -v thebibliography > secondfrontreferences2.bbl

figures:
	$(MAKE) -C figs

ifdef BIBFILE
$(MAINFILE).blg: $(BIBFILE).bib
	$(LATEX) $(MAINFILE).tex
	bibtex $(MAINFILE)  || true
	bibtex $(MAINFILE)  || true
	$(LATEX) $(MAINFILE).tex

# got a  "Recursive variable `DEPS' references itself" with this def of DEPS
#DEPS=$(MAINFILE).blg $(DEPS)
DEPS=$(MAINFILE).tex figures frontreferences2.bbl secondfrontreferences2.bbl $(MAINFILE).blg 
endif

ifdef PDFLATEX
$(PRIMTARGET): $(DEPS)
	$(MAKE) latexprocess
else
$(PRIMTARGET): $(MAINFILE).dvi
endif

$(MAINFILE).dvi: $(DEPS)
	$(MAKE) latexprocess

$(MAINFILE).ps: $(MAINFILE).dvi
	dvips -Ppdf -G0 -o $(MAINFILE).ps $(MAINFILE).dvi

$(MAINFILE)2.ps: $(MAINFILE).ps
	pstops -pa4 '2:0L@0.95(1.1w,0h)+1L@0.95(1.1w,0.45h)' $< $@

latexprocess:
	$(LATEX) $(MAINFILE).tex
	if egrep -i "rerun" $(MAINFILE).log ; then $(LATEX) $(MAINFILE).tex ; fi
	if egrep -i "rerun" $(MAINFILE).log ; then $(LATEX) $(MAINFILE).tex ; fi
	if egrep -i "rerun" $(MAINFILE).log ; then $(LATEX) $(MAINFILE).tex ; fi

$(MAINFILE).pdf:


clean:
	$(MAKE) -C figs clean
	for suff in log aux dvi ps pdf blg bbl toc ; do rm -f $(MAINFILE).$$suff frontreferences.$$suff secondfrontreferences.$$suff frontreferences2.$$suff secondfrontreferences2.$$suff ; done
	rm -f *~
	rm -f $(MAINFILE)2.ps


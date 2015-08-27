PY=python
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style

BIBFILE=/Users/Andrew/.pandoc/references.json
# orig: BIBFILE=$(INPUTDIR)/references.json

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        generate a web version             '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make docx	                       generate a Docx file 			  '
	@echo '   make tex	                       generate a Latex file 			  '

pdf:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	--template="$(STYLEDIR)/thesis.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl=chicago-fullnote-bibliography.csl \
	-V fontsize=12pt \
	-V papersize=letterpaper \
	-V geometry:"top=2cm, bottom=1.5cm, left=1cm, right=1cm" \
	-V documentclass=report \
	-V citecolor=black \
	-V toccolor=black \
	-V urlcolor=black \
	-V linkcolor=black \
	-V lang=english \
	-V lof \
	-V lot \
	--number-sections \
	--chapters \
	--latex-engine=xelatex
	--table-of-contents \
	--smart \
	--standalone

tex:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.tex" \
	--template="$(STYLEDIR)/thesis.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl=chicago-fullnote-bibliography.csl \
	-V fontsize=12pt \
	-V papersize=letterpaper \
	-V geometry:"top=2cm, bottom=1.5cm, left=1cm, right=1cm" \
	-V documentclass=report \
	-V citecolor=black \
	-V toccolor=black \
	-V urlcolor=black \
	-V linkcolor=black \
	-V lang=english \
	-V lof \
	-V lot \
	--number-sections \
	--chapters \
	--latex-engine=xelatex
	--table-of-contents \
	--smart \
	--standalone

docx:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.docx" \
	--bibliography="$(BIBFILE)" \
	--csl="$(STYLEDIR)/ref_format.csl" \
	--toc

html:
	pandoc "$(INPUTDIR)"/*.md \
	-t html5 \
	-o "$(OUTPUTDIR)/thesis.html" \
	--template="$(STYLEDIR)/template.html" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl=chicago-fullnote-bibliography.csl \
	--include-in-header="$(STYLEDIR)/style.css" \
	--toc \
	-V lof \
	-V lot \
	--number-sections \
	--section-divs \
	--smart \
	--standalone
	rm -rf "$(OUTPUTDIR)/source"
	mkdir "$(OUTPUTDIR)/source"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)/source/figures"

.PHONY: help pdf docx html tex

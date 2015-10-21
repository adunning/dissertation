PY=python
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style

BIBFILE=/Users/Andrew/.pandoc/references.json
# orig: BIBFILE=$(INPUTDIR)/references.json

all: pdf html

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make html                        generate a web version             '
	@echo '   make docx	                       generate a Docx file 			  '

pdf:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	--template="$(STYLEDIR)/thesis.tex" \
	--bibliography="$(BIBFILE)" \
	-V documentclass=ut-thesis \
	-V hidelinks \
	-V indent \
	-V subparagraph \
	-V substitute \
	-V lof \
	-V lot \
	-V mainfont="Arno Pro" \
	-V mainfontoptions=Numbers=OldStyle,Numbers=Proportional \
	--default-image-extension=pdf \
	--number-sections \
	--chapters \
	--latex-engine=lualatex \
	--table-of-contents \
	--no-tex-ligatures \
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
	--bibliography="$(BIBFILE)" \
	--css="$(STYLEDIR)/style.css" \
	--table-of-contents \
	-V link-citations=true \
	--default-image-extension=svg \
	--number-sections \
	--section-divs \
	--smart \
	--standalone
	rm -rf "$(OUTPUTDIR)/figures" "$(OUTPUTDIR)/style.css"
	cp -r "$(INPUTDIR)/figures" "$(OUTPUTDIR)"
	cp -r "$(STYLEDIR)/style.css" "$(OUTPUTDIR)"

.PHONY: help pdf docx html tex

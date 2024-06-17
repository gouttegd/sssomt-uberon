all: paper.pdf presentation clean

# Graphic files

PNGS = svgs/bridges.png \
       svgs/pipeline.png \
       svgs/relations.png \
       svgs/ccby.png

INKSCAPE = inkscape

%.png: %.svg
	$(INKSCAPE) --export-type=png --export-filename=$@ $<


# Paper

paper.pdf: paper.tex sssomt.bib $(PNGS)
	latexmk -lualatex paper


# Presentation

presentation: screen.pdf handout.pdf notes.pdf

PRESENTATION_SOURCES = presentation.tex revision.tex svgs/ccby.png

screen.pdf: screen.tex $(PRESENTATION_SOURCES)
	latexmk -lualatex screen

handout.pdf: handout.tex $(PRESENTATION_SOURCES)
	latexmk -lualatex handout

notes.pdf: notes.tex $(PRESENTATION_SOURCES)
	latexmk -lualatex notes


# Helper targets

revision.tex:
	git show -s --format='%aD %H' > revision.tex

sssomt-uberon.tar.gz: revision.tex $(PNGS)
	dir=$$(basename $$PWD) && \
	tar czf $@ -C .. \
		$$dir/{COPYING,Makefile,README.md,sssomt.bib} \
		$$dir/{handout,notes,screen,presentation,paper,revision}.tex \
		$$dir/svgs/{bridges,pipeline,relations,ccby}.{svg,png}

archive: sssomt-uberon.tar.gz

# Cleanup

.PHONY: clean mrproper
clean:
	rm -f {paper,screen,handout,notes}.{abs,aux,bbl,blg,fdb_latexmk,fls,log,nav,out,snm,toc,vrb,xmpdata}

mrproper: clean
	rm -f {paper,screen,handout,notes}.pdf

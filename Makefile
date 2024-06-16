TEXFILES = presentation.tex

all: screen.pdf handout.pdf notes.pdf clean

%.pdf: %.tex $(TEXFILES) svgs/ccbysa.png
	latexmk -lualatex $<

clean:
	rm -f {screen,dualscreen,handout,notes}.{aux,fdb_latexmk,fls,log,nav,out,snm,toc,vrb}

mrproper: clean
	rm -f {screen,dualscreen,handout,notes}.pdf presentation.tex

%.png: %.svg
	inkscape --export-type=png --export-filename=$@ $<

.PHONY: clean mrproper

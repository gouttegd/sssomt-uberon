PNGS = svgs/bridges.png \
       svgs/pipeline.png \
       svgs/relations.png

INKSCAPE = inkscape

paper.pdf: paper.tex sssomt.bib $(PNGS)
	latexmk -lualatex paper

%.png: %.svg
	$(INKSCAPE) --export-type=png --export-filename=$@ $<

.PHONY: clean
clean:
	latexmk -c paper

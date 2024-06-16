PNGS = figs/bridges.png \
       figs/pipeline.png \
       figs/relations.png

INKSCAPE = inkscape

paper.pdf: paper.tex sssomt.bib $(PNGS)
	latexmk -lualatex paper

%.png: %.svg
	$(INKSCAPE) --export-type=png --export-filename=$@ $<

.PHONY: clean
clean:
	latexmk -c paper

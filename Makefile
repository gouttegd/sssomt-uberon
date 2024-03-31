PNGS = figs/bridges.png \
       figs/pipeline.png \
       figs/relations.png

INKSCAPE = inkscape

sssomt.pdf: sssomt.tex sssomt.bib $(PNGS)
	latexmk -lualatex sssomt

%.png: %.svg
	$(INKSCAPE) --export-type=png --export-filename=$@ $<

.PHONY: clean
clean:
	latexmk -c sssomt

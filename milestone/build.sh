rm -f maheswaranathan_milestone.log maheswaranathan_milestone.ps maheswaranathan_milestone.toc maheswaranathan_milestone.aux maheswaranathan_milestone.dvi maheswaranathan_milestone.pdf maheswaranathan_milestone.out &&
pdflatex maheswaranathan_milestone.tex &&
bibtex maheswaranathan_milestone.aux &&
pdflatex maheswaranathan_milestone.tex &&
pdflatex maheswaranathan_milestone.tex &&
#dvipdf maheswaranathan_milestone.dvi &&
#dvips maheswaranathan_milestone.dvi
rm -f maheswaranathan_milestone.log maheswaranathan_milestone.toc maheswaranathan_milestone.aux maheswaranathan_milestone.bbl maheswaranathan_milestone.blg maheswaranathan_milestone.dvi maheswaranathan_milestone.ps maheswaranathan_milestone.out

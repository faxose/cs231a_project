rm -f maheswaranathan_paper.log maheswaranathan_paper.ps maheswaranathan_paper.toc maheswaranathan_paper.aux maheswaranathan_paper.dvi maheswaranathan_paper.pdf maheswaranathan_paper.out &&
pdflatex maheswaranathan_paper.tex &&
bibtex maheswaranathan_paper.aux &&
pdflatex maheswaranathan_paper.tex &&
pdflatex maheswaranathan_paper.tex &&
#dvipdf maheswaranathan_paper.dvi &&
#dvips maheswaranathan_paper.dvi
rm -f maheswaranathan_paper.log maheswaranathan_paper.toc maheswaranathan_paper.aux maheswaranathan_paper.bbl maheswaranathan_paper.blg maheswaranathan_paper.dvi maheswaranathan_paper.ps maheswaranathan_paper.out

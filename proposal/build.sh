rm -f maheswaranathan_proposal.log maheswaranathan_proposal.ps maheswaranathan_proposal.toc maheswaranathan_proposal.aux maheswaranathan_proposal.dvi maheswaranathan_proposal.pdf maheswaranathan_proposal.out &&
pdflatex maheswaranathan_proposal.tex &&
#bibtex maheswaranathan_proposal.aux &&
pdflatex maheswaranathan_proposal.tex &&
pdflatex maheswaranathan_proposal.tex &&
#dvipdf maheswaranathan_proposal.dvi &&
#dvips maheswaranathan_proposal.dvi
rm -f maheswaranathan_proposal.log maheswaranathan_proposal.toc maheswaranathan_proposal.aux maheswaranathan_proposal.bbl maheswaranathan_proposal.blg maheswaranathan_proposal.dvi maheswaranathan_proposal.ps maheswaranathan_proposal.out

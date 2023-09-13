#!/bin/bash +x

if [[ $# -ne 1 ]]; then
    echo "Usage: ./build.sh <pl/en>"
    exit -1
fi

PTEX=pdflatex    
BTEX=bibtex

which ${PTEX} || exit -1
which ${BTEX} || exit -1

TEXF="thesis_$1.tex"
AUXF="thesis_$1.aux"

ls ${TEXF} || exit -1


echo "=============================================== Running the #1 pass of pdflatex"
${PTEX} --shell-escape ${TEXF} || exit -2
echo "=============================================== Done"
echo "=============================================== Running bibtex"
${BTEX} ${AUXF}  || exit -2
echo "=============================================== Done"
echo "=============================================== Running the #2 pass of pdflatex"
${PTEX} --shell-escape ${TEXF} || exit -2
echo "=============================================== Done"
echo "=============================================== Running the #3 pass of pdflatex"
${PTEX} --shell-escape ${TEXF} || exit -2
echo "=============================================== Done"


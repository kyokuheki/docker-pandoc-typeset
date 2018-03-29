#!/bin/bash

set -eo pipefail
shopt -s nullglob

PROGNAME=ts
PANDOC_OPTS="-s --verbose --from markdown_github+raw_tex --pdf-engine=lualatex --template=/pandoc/template.tex --include-in-header=/pandoc/header.tex -N --toc --toc-depth=2 -V documentclass=ltjsarticle -V geometry:margin=3cm -V papersize=a4 -V luatexjapresetoptions=noto-otf -V 'mainfont=TeXGyreTermes' -V mainfontoptions=Ligatures=TeX,Scale=0.95 -V 'sansfont=TeXGyreHeros' -V sansfontoptions=Ligatures=TeX,Scale=0.95 -V monofont=Inconsolatazi4"

# skip setup if they want an option that stops
wantHelp=
for arg; do
    case "$arg" in
        -'?'|--help|-h|-V|--version)
            wantHelp=1
            break
            ;;
    esac
done

if [ -n "$wantHelp" ]; then
    cat <<_EOT_
usage: ${PROGNAME} typeset [OPTION] cover.pdf title.pdf [MARKDOWN.md]...
   or: ${PROGNAME} draft [MARKDOWN.md]...
   or: ${PROGNAME} pandoc [PANDOC_ARGUMENT]...

This script execute pandoc.

COMMANDS:
    typeset                   bind a book with pdf files such as cover.
    draft                     convert markdown files into body.pdf.
    pandoc                    execute pandoc directly with your arguments.

TYPESET OPTIONS:
    -ebook                    selects medium-resolution output similar to 
                              the Acrobat Distiller "eBook" setting.
    -prepress                 selects output similar to Acrobat Distiller 
                              "Prepress Optimized" setting.

EXAMPLES:
    ${PROGNAME} typeset -ebook cover.pdf title.pdf intro.md body.md concl.md

    ${PROGNAME} draft intro.md sec1.md sec2.md concl.md

    ${PROGNAME} pandoc $PANDOC_OPTS intro.md sec1.md sec2.md concl.md

_EOT_
    exit 1
fi

# execute pandoc
if [ "$1" = "pandoc" -a -z "$wantHelp" ]; then
    exec "$@"
fi

# draft
if [ "$1" = "draft" ]; then
    shift
    exec /usr/bin/pandoc -o body.pdf $PANDOC_OPTS "$@"
fi

# execute pandoc
if [ "$1" = "typeset" -a -z "$wantHelp" ]; then
    shift

    #if [ "${1:0:1}" = '-' ]; then
    dPDFSETTINGS=
    if [ "$1" = '-ebook' -o "$1" = '-prepress' ]; then
        dPDFSETTINGS=/${1##-}
        shift
    fi
    
    PDFs=
    while [ -z ${1%%*.pdf} ];
    do
        PDFs="$PDFs $1"
        shift
    done
    
    /usr/bin/pandoc -o body.pdf $PANDOC_OPTS "$@"
    if [ -z "$dPDFSETTINGS" ]; then
        gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.9 -sOutputFile=final.pdf $PDFs body.pdf
    else
        gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.9 -dPDFSETTINGS=$dPDFSETTINGS -sOutputFile=final.pdf $PDFs body.pdf
    fi
fi

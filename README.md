# docker-pandoc-typeset
Containerized PDF builder from pdfs and markdown files using pandoc and ghostscript

## Usage
Get usage

```sh
docker run -it --rm -v $PWD:/src kyokuheki/pandoc-typeset typeset -h
```

Typeset markdown files and PDF files

```sh
docker run -it --rm -v $PWD:/src kyokuheki/pandoc-typeset typeset -prepress cover.pdf title.pdf 1.md 2.md...
```

Convert markdown files into body.pdf

```
docker run -it --rm -v $PWD:/src kyokuheki/pandoc-typeset draft *.md
```

Execute pandoc

```sh
docker run -it --rm -v $PWD:/src kyokuheki/pandoc pandoc [arguments]...
```

Enter the console

```sh
docker run -it --rm -v $PWD:/src --entrypoint bash kyokuheki/pandoc
```

## Preset Configurations
- mainfont: TeX Gyre Termes (Ligatures=TeX,Scale=0.95)
- sansfont: TeX Gyre Heros (Ligatures=TeX,Scale=0.95)
- monofont: Inconsolatazi4
- luatexja-preset: noto-otf
- documentclass: ltjsarticle
- from: markdown_github+raw_tex
- pdf-engine: lualatex

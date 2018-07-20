# docker-pandoc-typeset
[![](https://img.shields.io/docker/automated/kyokuheki/pandoc-typeset.svg)](https://hub.docker.com/r/kyokuheki/pandoc-typeset/)
[![](https://img.shields.io/docker/stars/kyokuheki/pandoc-typeset.svg)](https://hub.docker.com/r/kyokuheki/pandoc-typeset/)
[![](https://img.shields.io/docker/pulls/kyokuheki/pandoc-typeset.svg)](https://hub.docker.com/r/kyokuheki/pandoc-typeset/)
[![](https://images.microbadger.com/badges/version/kyokuheki/pandoc-typeset.svg)](https://microbadger.com/images/kyokuheki/pandoc-typeset "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/kyokuheki/pandoc-typeset.svg)](https://microbadger.com/images/kyokuheki/pandoc-typeset "Get your own image badge on microbadger.com")

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
docker run -it --rm -v $PWD:/src kyokuheki/pandoc-typeset pandoc [arguments]...
```

Convert markdown files into html5

```sh
docker run -it --rm -v $PWD:/src kyokuheki/pandoc-typeset pandoc *.md -o test.html -t html5 --standalone --self-contained
```

Enter the console

```sh
docker run -it --rm -v $PWD:/src --entrypoint bash kyokuheki/pandoc-typeset
```

## Preset Configurations
- mainfont: TeX Gyre Termes (Ligatures=TeX,Scale=0.95)
- sansfont: TeX Gyre Heros (Ligatures=TeX,Scale=0.95)
- monofont: Inconsolatazi4
- mathfont: XITS Math
- luatexja-preset: noto-otf
- documentclass: ltjsarticle
- from: markdown_github+raw_tex
- pdf-engine: lualatex

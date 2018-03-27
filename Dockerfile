FROM kyokuheki:docker-pandoc
LABEL maintainer Kenzo Okuda <okuda.kenzo@nttv6.net>

COPY assets/header.tex /pandoc/header.tex
COPY assets/template.tex /pandoc/template.tex
COPY assets/entrypoint.sh /bin/entrypoint.sh

VOLUME ["/src"]
WORKDIR /src

ENTRYPOINT ["/bin/entrypoint.sh"]

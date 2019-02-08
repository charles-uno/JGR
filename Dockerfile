
from opensuse

RUN zypper install -y \
    python

RUN zypper install -y \
    texlive-collection-latex \
    texlive-scheme-full

RUN zypper install -y \
    make \
    which

RUN mkdir -p /workdir/
ADD agu-template/* /workdir/
WORKDIR /workdir/

CMD /bin/bash

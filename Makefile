
SOURCE := jgr.tex
FILES := $(SOURCE) bibliography.bib Makefile figures

# NOTE -- also depends on figures, bib, template...

TODAY := $(shell date +"%Y%m%d")

IMAGE := jgr-build-image

MOUNT := /mount
WORKDIR := /workdir

.PHONY: all image pdf pdf-helper
all: pdf

image:
	docker build . -f Dockerfile -t $(IMAGE)

pdf: image
	docker run --rm --mount type=bind,source=$(PWD),target=$(MOUNT) $(IMAGE) make --directory=$(MOUNT) --file=$(MOUNT)/Makefile pdf-helper

pdf-helper:
	cd $(MOUNT); cp -r $(FILES) $(WORKDIR)
	cd $(WORKDIR); latexmk -pdf $(SOURCE) -halt-on-error --shell-escape
	mv $(WORKDIR)/*.pdf $(WORKDIR)/*.bbl $(MOUNT)

debug:
	docker run --rm -it --mount type=bind,source=$(PWD),target=$(MOUNT) $(IMAGE)

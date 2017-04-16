SHAREDIR=$(DESTDIR)/usr/share/ldvsoft/vim
BINDIR=$(DESTDIR)/usr/bin

all:

install:
	mkdir -p $(SHAREDIR) $(BINDIR)
	cp -r --preserve=mode,timestamps share/* $(SHAREDIR)/
	cp -r --preserve=mode,timestamps bin/* $(BINDIR)/

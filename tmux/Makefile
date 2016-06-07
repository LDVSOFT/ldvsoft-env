INSTALLDIR=$(DESTDIR)/usr/share/ldvsoft/tmux
BINDIR=$(DESTDIR)/usr/bin

all:

install:
	mkdir -p $(INSTALLDIR)
	mkdir -p $(BINDIR)
	cp -r --preserve=mode,timestamps tmux/* $(INSTALLDIR)/
	ln -fs $(INSTALLDIR)/tmux-status-left.sh $(BINDIR)/tmux-status-left
	ln -fs $(INSTALLDIR)/tmux-status-right.sh $(BINDIR)/tmux-status-right
	ln -fs $(INSTALLDIR)/new-pane.sh $(BINDIR)/tmux-new-pane

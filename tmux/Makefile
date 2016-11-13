INSTALL=/usr/share/ldvsoft/tmux
INSTALLDIR=$(DESTDIR)$(INSTALL)
BINDIR=$(DESTDIR)/usr/bin

all:

install:
	mkdir -p $(INSTALLDIR)
	mkdir -p $(BINDIR)
	cp -r --preserve=mode,timestamps tmux/* $(INSTALLDIR)/
	ln -sf $(INSTALL)/tmux-status-left.sh $(BINDIR)/tmux-status-left
	ln -sf $(INSTALL)/tmux-status-right.sh $(BINDIR)/tmux-status-right
	ln -sf $(INSTALL)/new-pane.sh $(BINDIR)/tmux-new-pane

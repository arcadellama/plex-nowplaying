PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

all:
	@echo RUN \'make install\' to install nowplaying

install:
	@install -d  $(DESTDIR)$(BINDIR)
	@install -m755 nowplaying $(DESTDIR)$(BINDIR)/nowplaying

uninstall:
	@rm -f $(DESTDIR)$(BINDIR)/nowplaying

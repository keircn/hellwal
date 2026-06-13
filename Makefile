VERSION := $(shell cat VERSION)

CFLAGS = -Wall -Wextra -O3
LDFLAGS = -lm

DESTDIR = /usr/local/bin

roxgen: roxgen.c
	$(CC) $(CFLAGS) roxgen.c -o roxgen $(LDFLAGS) -DVERSION=\"$(VERSION)\"

debug: roxgen.c
	$(CC) $(CFLAGS) -ggdb roxgen.c -o roxgen $(LDFLAGS) -DVERSION=\"$(VERSION)\"

clean:
	rm -f roxgen

install: roxgen
	mkdir -p $(DESTDIR)
	cp -f roxgen $(DESTDIR)
	chmod 755 $(DESTDIR)/roxgen # chmod u=rwx,g=rx,o=rx

uninstall:
	rm -f $(DESTDIR)/roxgen

release: roxgen
	tar czf roxgen-v$(VERSION).tar.gz roxgen

.PHONY: roxgen debug release clean install uninstall

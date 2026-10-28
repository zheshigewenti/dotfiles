SHELL := /bin/sh

PACKAGES := zsh git nvim tmux lf mpv im
STOW := stow -d $(CURDIR) -t $(HOME)

.PHONY: link unlink im bootstrap

link:
	$(STOW) $(PACKAGES)

unlink:
	$(STOW) -D $(PACKAGES)

im:
	$(MAKE) -C $(HOME)/.local/share/im install

bootstrap:
	git submodule update --init --recursive
	brew bundle --file=$(CURDIR)/Brewfile
	$(MAKE) link
	$(MAKE) im

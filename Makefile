.PHONY: install brew mise

# The Makefile is here for exactly two things: Homebrew and mise, the only
# pieces mise cannot install for itself. Everything else is declared in
# mise.toml, and the commands are mise's own: `mise bootstrap`, `mise upgrade`,
# `mise run lint`.

# On a fresh mac Homebrew's prefix is not on PATH — the installer only prints
# the shellenv line, it never writes it anywhere — and every recipe line below
# is a separate shell that inherits make's environment. Without this both `brew`
# and the `mise` it installs are unresolvable. The prefix is derived from the
# arch rather than probed, because at parse time brew does not exist yet.
BREW_PREFIX := $(shell [ "$$(uname -m)" = arm64 ] && echo /opt/homebrew || echo /usr/local)
export PATH := $(BREW_PREFIX)/bin:$(PATH)

install: mise
	mise bootstrap --yes

# The same installer, and the same NONINTERACTIVE=1, as
# [bootstrap.hooks.pre-packages] in mise.toml — that hook covers the path where
# bootstrap is run without the Makefile. Whichever runs first wins and the other
# sees brew and does nothing. It still asks for a sudo password.
brew:
	@command -v brew >/dev/null 2>&1 || \
	  NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

mise: brew
	brew install mise

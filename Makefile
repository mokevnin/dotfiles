.PHONY: install mise

# The Makefile is here for exactly one thing: installing mise, the only piece
# mise cannot install for itself. Everything else is declared in mise.toml, and
# the commands are mise's own: `mise bootstrap`, `mise upgrade`, `mise run lint`.

install: mise
	mise bootstrap --yes

mise:
	brew install mise

.PHONY: install mise

# The Makefile is here for exactly one thing: installing mise, the only piece
# mise cannot install for itself. Everything else is declared in mise.toml, and
# the commands are mise's own: `mise bootstrap`, `mise upgrade`, `mise run lint`.

# mise.run drops the binary into ~/.local/bin, which is not on PATH by default —
# without this line install fails on a fresh mac with command not found.
export PATH := $(HOME)/.local/bin:$(PATH)

install: mise
	mise bootstrap --yes

mise:
	@command -v mise >/dev/null 2>&1 && exit 0; \
	if command -v brew >/dev/null 2>&1; then brew install mise; \
	else curl -fsSL https://mise.run | sh; fi

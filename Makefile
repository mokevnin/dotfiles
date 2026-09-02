.PHONY: install mise bootstrap upgrade lint

# Makefile нужен ровно для двух вещей: поставить сам mise (единственное, что он
# не может поставить себе сам) и дать короткие имена его командам.
# Всё остальное описано декларативно в mise.toml.

install: mise bootstrap

mise:
	@command -v mise >/dev/null 2>&1 && exit 0; \
	if command -v brew >/dev/null 2>&1; then brew install mise; \
	else curl -fsSL https://mise.run | sh; fi

bootstrap:
	mise bootstrap --yes

upgrade:
	mise upgrade

lint:
	actionlint
	cd nvim && stylua --check lua

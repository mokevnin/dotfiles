.PHONY: install mise

# Makefile нужен ровно для одного: поставить сам mise — единственное, что он не
# может поставить себе сам. Всё остальное описано декларативно в mise.toml,
# а команды — это сам mise: `mise bootstrap`, `mise upgrade`, `mise run lint`.

# mise.run кладёт бинарь в ~/.local/bin, которого нет в PATH по умолчанию, —
# без этой строки install на свежем маке падает с command not found.
export PATH := $(HOME)/.local/bin:$(PATH)

install: mise
	mise bootstrap --yes

mise:
	@command -v mise >/dev/null 2>&1 && exit 0; \
	if command -v brew >/dev/null 2>&1; then brew install mise; \
	else curl -fsSL https://mise.run | sh; fi

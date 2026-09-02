# dotfiles

Вся машина описана декларативно в одном файле — [`mise.toml`](mise.toml).
Его применяет [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): системные
пакеты, git-репозитории, симлинки дотфайлов, активация шелла, login shell и тулы.

## Установка

Свежая машина, с нуля:

```sh
mise bootstrap --from git@github.com:mokevnin/dotfiles.git --from-dir ~/dotfiles --yes
```

Если mise ещё не стоит (единственное, что он не может поставить себе сам):

```sh
git clone git@github.com:mokevnin/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install          # поставит mise через brew или mise.run, потом mise bootstrap --yes
```

## Команды

```sh
make install     # mise + mise bootstrap --yes
make bootstrap   # mise bootstrap --yes
make upgrade     # mise upgrade
make lint        # actionlint

mise bootstrap --dry-run     # посмотреть, что изменится
mise bootstrap status        # состояние всех декларативных частей
mise bootstrap --only tools  # применить только часть
```

Makefile существует ровно для двух вещей: поставить сам mise и дать короткие
имена его командам. Никакой логики установки в нём нет.

## Что где

| Секция `mise.toml` | Что описывает |
|---|---|
| `[tools]` | Языки и CLI-утилиты. Бэкенды: реестр, `npm:`, `gem:`, `ubi:` |
| `[bootstrap.packages]` | Системные пакеты. `brew:`/`brew-cask:` mise ставит сам, Homebrew не нужен; `apt:` пропускается на macOS |
| `[bootstrap.repos]` | Git-репозитории (плагин you-should-use) |
| `[dotfiles]` | Симлинки: `~/.config/nvim`, `~/.config/mise/config.toml` |
| `[bootstrap.mise_shell_activate]` | Блок `mise activate` в `.zshrc` между маркерами |
| `[bootstrap.user]` | login shell |
| `[bootstrap.hooks.pre-repos]` | Установка oh-my-zsh перед клонированием его плагинов |
| `[tasks.bootstrap]` | `omz plugin enable` — единственное, что осталось императивным |

`mise.toml` симлинкуется в `~/.config/mise/config.toml`, поэтому тулы глобальные
и доступны из любой директории.

Добавить тул — строка в `[tools]`, потом `mise install`.
Добавить системный пакет — `mise bootstrap packages use brew:foo`.
Забрать в репо изменённый дотфайл — `mise bootstrap dotfiles add ~/.foo`.

## Замены утилит

Часть классики заменена на современные аналоги, которые есть в бэкендах mise:

| было | стало |
|---|---|
| htop | bottom (`btm`) |
| ncdu | gdu |
| httpie | xh |
| gnu-sed | sd |
| tldr | tealdeer |
| the_silver_searcher | ripgrep (уже был) |

## VIM

[LazyVim](https://www.lazyvim.org/), конфиг в `nvim/`.

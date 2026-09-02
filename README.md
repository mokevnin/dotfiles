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

## Что стоит

Всё в `[tools]`, ставится `mise install`. Сейчас 64 тула:

- **языки** — go, java (temurin 25), node, python, ruby, pnpm, ansible
- **навигация** — zoxide, eza, yazi, fd, fzf, ripgrep, television нет (хватает fzf)
- **git/forge** — lazygit, delta, difftastic, gh, glab
- **инфра** — docker-cli, docker-compose, lazydocker, terraform, helm, kubectl, k9s, kubectx, stern, sentry-cli
- **AI** — claude-code, codex, copilot-cli, opencode
- **разное** — atuin, bat, bottom, dust, duf, gdu, glow, hyperfine, jq, yq, just, sd, tokei, watchexec, xh, sesh, viu, chafa, pandoc

Заменённая классика:

| было | стало |
|---|---|
| htop | bottom (`btm`) |
| ncdu | gdu |
| du / df | dust / duf |
| httpie | xh |
| gnu-sed | sd |
| ls | eza |
| cd | zoxide |
| tldr | tealdeer |
| the_silver_searcher | ripgrep |

`wget`, `sox`, ghostty и шрифты идут через `[bootstrap.packages]` как
`brew:`/`brew-cask:` — ставит их всё равно mise, Homebrew для этого не нужен.

Одно исключение — **`yc`** (Yandex Cloud). Каск `yandex-cloud-cli` есть, но
поставить его не выходит ни тем, ни другим путём: `brew` выполняет стансу
`installer script` через `sudo`, а mise на этом каске теряет путь к бинарю
(`binary artifact 'yandex-cloud-cli/bin/yc' was not found`). Поэтому yc ставится
родным скриптом вендора из `[bootstrap.hooks.post-tools]` — он работает без root —
а его каталог добавляется в PATH управляемой строкой в `[dotfiles]`.

## VIM

[LazyVim](https://www.lazyvim.org/), конфиг в `nvim/`.

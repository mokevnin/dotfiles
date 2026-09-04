# dotfiles

Вся машина описана декларативно в одном файле — [`mise.toml`](mise.toml).
Только под macOS.
Его применяет [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): системные
пакеты, git-репозитории, симлинки дотфайлов, активация шелла, login shell и тулы.

## Установка

Свежая машина, с нуля. `git` и `make` на чистой macOS — заглушки, поэтому
первая же команда попросит поставить Xcode Command Line Tools; можно заранее:

```sh
xcode-select --install
```

Дальше, mise ещё нет (единственное, что он не может поставить себе сам).
URL по https — ssh-ключей на новой машине пока нет:

```sh
git clone https://github.com/mokevnin/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install          # поставит mise через brew или mise.run, потом mise bootstrap --yes
```

Если mise уже есть, всё делается одной командой:

```sh
mise bootstrap --from https://github.com/mokevnin/dotfiles.git --from-dir ~/dotfiles --yes
```

Потом переключить remote на ssh: `git remote set-url origin git@github.com:mokevnin/dotfiles.git`.

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
| `[tools]` | Языки и CLI-утилиты. Бэкенды: реестр, `npm:`, `gem:`, `pipx:`, `github:` |
| `[bootstrap.packages]` | Системные пакеты и GUI-приложения. `brew:`/`brew-cask:` mise ставит через сам Homebrew |
| `[bootstrap.repos]` | Git-репозитории (плагин you-should-use) |
| `[dotfiles]` | Симлинки (`~/.config/nvim`, `~/.config/mise/config.toml`, `~/.gitconfig`) и управляемые строки в `.zshrc` |
| `[bootstrap.mise_shell_activate]` | Блок `mise activate` в `.zshrc` между маркерами |
| `[bootstrap.user]` | login shell |
| `[bootstrap.hooks.pre-packages]` | Установка Homebrew на macOS перед `brew:`-пакетами |
| `[bootstrap.hooks.pre-repos]` | Установка oh-my-zsh перед клонированием его плагинов |
| `[tasks.bootstrap]` | `omz plugin enable` — единственное, что осталось императивным |

`mise.toml` симлинкуется в `~/.config/mise/config.toml`, поэтому тулы глобальные
и доступны из любой директории. Но `mise bootstrap` надо запускать **из
`~/dotfiles`**: источники в `[dotfiles]` относительные, а mise разрешает их
относительно того файла конфига, через который загрузился, — из домашней
директории это `~/.config/mise/`, и все источники «пропадают». Абсолютные пути
тут не помогают: тогда падает CI, где репозиторий лежит не в `~/dotfiles`.

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
- **разное** — atuin, bat, bottom, dust, duf, gdu, glow, hyperfine, jq, yq, just, sd, tokei, watchexec, xh, sesh, viu, pandoc

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

Через `[bootstrap.packages]` (`brew:`/`brew-cask:`) идёт всё, чего нет в mise:

- `wget`, `sox`, `tmux` (его требуют sesh и overmind, сами не тянут), `git-lfs`
  (фильтр `lfs` прописан в `gitconfig`);
- ghostty и nerd-шрифты;
- Docker Desktop (без демона `docker-cli` бесполезен) и 1Password (его
  `op-ssh-sign` подписывает коммиты);
- GUI: Chrome, VS Code, GitHub Desktop, Slack, Telegram, WhatsApp, ChatGPT,
  Claude, OBS, Audacity, Zoom, NordVPN.

Командует установкой mise, но работает он через сам Homebrew, поэтому на свежем
маке brew ставится хуком `[bootstrap.hooks.pre-packages]` — неинтерактивно, но
пароль для sudo установщик спросит. Пароль спросят и каски-`pkg`
(`docker-desktop`, `zoom`, `nordvpn`): brew ставит их через `installer(8)`, а не
копированием бандла. Префикс brew добавляется в PATH управляемой строкой в
`[dotfiles]`.

Одно исключение — **`yc`** (Yandex Cloud). Каск `yandex-cloud-cli` есть, но
поставить его не выходит ни тем, ни другим путём: `brew` выполняет стансу
`installer script` через `sudo`, а mise на этом каске теряет путь к бинарю
(`binary artifact 'yandex-cloud-cli/bin/yc' was not found`). Поэтому yc ставится
родным скриптом вендора из `[bootstrap.hooks.post-tools]` — он работает без root —
а его каталог добавляется в PATH управляемой строкой в `[dotfiles]`.

## VIM

[LazyVim](https://www.lazyvim.org/), конфиг в `nvim/`.

## Чего репо не переносит

Дотфайлы описывают машину, но не аккаунты. После bootstrap на новой машине
руками:

- ssh-ключи и `~/.ssh/config` (у ключей агент 1Password, `IdentityAgent`)
- логины: `gh auth login`, `glab auth login`, `atuin login`, claude, codex
- токены: `~/.npmrc` (npmjs + npm.pkg.github.com), а также
  `CODEX_GITHUB_PERSONAL_ACCESS_TOKEN` и `YANDEX_TRACKER_MCP_TOKEN` в `.zshrc` —
  им место в 1Password, а не в открытом виде
- `~/.kube`, `~/.docker` и прочий стейт клиентов

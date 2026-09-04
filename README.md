# dotfiles

Вся машина описана декларативно в одном файле — [`mise.toml`](mise.toml).
Только под macOS.
Его применяет [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): системные
пакеты, git-репозитории, симлинки дотфайлов, активация шелла, login shell и тулы.

## Новый мак, с нуля

Пять шагов. Три раза спросят пароль — это нормально, ниже сказано где.

### 1. Xcode Command Line Tools

`git` и `make` на чистой macOS — заглушки, поэтому первая же команда откроет
GUI-диалог установки. Лучше запустить его сразу и дождаться:

```sh
xcode-select --install
```

### 2. Достать токен GitHub

`[tools]` почти целиком на `latest`, поэтому mise ходит за версиями в
`api.github.com`, где анонимно можно 60 запросов в час — на 64 тула этого не
хватает. Обычно токен берётся у `gh` (`github.credential_command` в
`[settings]`), но на свежей машине `gh` ещё не авторизован, так что на первый
прогон PAT надо достать из 1Password руками (с телефона или веба). Без токена
bootstrap не падает, но тонет в `429` и ретраях.

### 3. Склонировать по https

Ssh-ключей на новой машине ещё нет, поэтому не `git@`:

```sh
git clone https://github.com/mokevnin/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Позже, когда ключи на месте: `git remote set-url origin git@github.com:mokevnin/dotfiles.git`.

### 4. Запустить

```sh
export GITHUB_TOKEN=…   # из шага 2
make install
```

`make install` = поставить сам mise (через brew, если он есть, иначе `mise.run`
в `~/.local/bin`) и выполнить `mise bootstrap --yes`. Запускать **из
`~/dotfiles`** — почему, написано ниже в «Что где». Флаг `--yes` нужен ещё и
затем, чтобы mise не спрашивал, доверяешь ли ты конфигу.

Что произойдёт, по порядку:

| | |
|---|---|
| хук `pre-packages` | ставит Homebrew — **спросит пароль** |
| `[bootstrap.packages]` | brew-формулы и каски, включая GUI-приложения. Каски-`pkg` (`docker-desktop`, `zoom`, `nordvpn`) идут через `installer(8)` и **спросят пароль** |
| хук `pre-repos` | ставит oh-my-zsh |
| `[bootstrap.repos]` | клонирует плагин you-should-use |
| `[dotfiles]` | симлинки `~/.config/nvim`, `~/.config/mise/config.toml`, `~/.gitconfig` и управляемые строки в `.zshrc` |
| `[bootstrap.mise_shell_activate]` | блок `mise activate` в `.zshrc` |
| `[bootstrap.user]` | login shell на `/bin/zsh` — **спросит пароль** |
| `mise install` | 64 тула. Самая долгая часть |
| хук `post-tools` | ставит `yc` скриптом вендора |
| `[tasks.bootstrap]` | `omz plugin enable` |

Если mise на машине уже есть, шаги 3–4 сворачиваются в одну команду:

```sh
mise bootstrap --from https://github.com/mokevnin/dotfiles.git --from-dir ~/dotfiles --yes
```

### 5. Новый шелл

```sh
exec zsh
```

До этого ни тулов, ни omz-плагинов в текущей сессии не будет — `.zshrc`
дописали уже после её старта.

### Что дальше — руками

Репо описывает машину, но не аккаунты. Само не приедет:

- ssh-ключи и `~/.ssh/config` — у ключей агент 1Password (`IdentityAgent`),
  им же подписываются коммиты (`op-ssh-sign` в `gitconfig`)
- логины: `gh auth login`, `glab auth login`, `atuin login`, claude, codex
- токены: `~/.npmrc` (npmjs + npm.pkg.github.com), а также
  `CODEX_GITHUB_PERSONAL_ACCESS_TOKEN` и `YANDEX_TRACKER_MCP_TOKEN` в `.zshrc` —
  им место в 1Password, а не в открытом виде
- `~/.kube`, `~/.docker` и прочий стейт клиентов
- первый запуск Docker Desktop и 1Password — они попросят разрешений системы

Проверить, что всё сошлось: `mise bootstrap status` — там должно быть
`installed`/`applied` по каждой строке.

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

Репозиторий публичный, так что `dotfiles add` — единственное место, где сюда
может утечь секрет: команда копирует файл целиком. Перед коммитом смотреть, что
именно приехало. Токены и ключи тут не хранятся и не должны — им место
в 1Password. В `gitconfig` из чувствительного только `user.signingkey`, и это
**публичная** половина ssh-ключа, ровно та, что и так лежит на
<https://github.com/mokevnin.keys>.

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

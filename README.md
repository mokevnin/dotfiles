# dotfiles

The whole machine is described declaratively in a single file — [`mise.toml`](mise.toml).
macOS only.
It is applied by [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): system
packages, git repos, dotfile symlinks, shell activation, login shell and tools.

## A new mac, from scratch

Five steps. You will be asked for a password three times — that is normal, it is
spelled out below where.

### 1. Xcode Command Line Tools

On a clean macOS `git` and `make` are stubs, so the very first command pops up
the GUI installer. Better to launch it up front and wait:

```sh
xcode-select --install
```

### 2. Get a GitHub token

`[tools]` is almost entirely on `latest`, so mise goes to `api.github.com` for
versions, where anonymous access gets 60 requests per hour — not enough for a
toolset this size. Normally the token comes from `gh`
(`github.credential_command` in `[settings]`), but on a fresh machine `gh` is not
authenticated yet, so for the first run the PAT has to be pulled out of 1Password
by hand (from a phone or the web). Without a token bootstrap does not fail, but it drowns in `429`s and
retries.

### 3. Clone over https

There are no ssh keys on a new machine yet, so not `git@`:

```sh
git clone https://github.com/mokevnin/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Later, once the keys are in place: `git remote set-url origin git@github.com:mokevnin/dotfiles.git`.

### 4. Run it

```sh
export GITHUB_TOKEN=…   # from step 2
make install
```

`make install` = install mise itself (via brew if it is there, otherwise
`mise.run` into `~/.local/bin`) and run `mise bootstrap --yes`. Run it **from
`~/dotfiles`** — why, is explained below in "What lives where". The `--yes` flag
is also what keeps mise from asking whether you trust the config.

What happens, in order:

| | |
|---|---|
| `pre-packages` hook | installs Homebrew — **asks for a password** |
| `[bootstrap.packages]` | brew formulae and casks, GUI apps included. `pkg` casks (`docker-desktop`, `zoom`, `nordvpn`) go through `installer(8)` and **ask for a password** |
| `pre-repos` hook | installs oh-my-zsh |
| `[bootstrap.repos]` | clones the you-should-use plugin |
| `[dotfiles]` | symlinks `~/.config/nvim`, `~/.config/mise/config.toml`, `~/.gitconfig`, the `useful.zsh` snippet for oh-my-zsh, and the managed lines in `.zshrc` (`mise-path`, `atuin`, `brew`, `yc`) |
| `[bootstrap.mise_shell_activate]` | the `mise activate` block in `.zshrc` |
| `[bootstrap.user]` | login shell set to `/bin/zsh` — **asks for a password** |
| `mise install` | the whole toolset. The longest part |
| `post-tools` hook | installs `yc` from the vendor script |
| `[tasks.bootstrap]` | `omz plugin enable` |

If mise is already on the machine, steps 3–4 collapse into a single command:

```sh
mise bootstrap --from https://github.com/mokevnin/dotfiles.git --from-dir ~/dotfiles --yes
```

### 5. A new shell

```sh
exec zsh
```

Until then neither the tools nor the omz plugins exist in the current session —
`.zshrc` was written after it had already started.

### What is left to do by hand

The repo describes the machine, but not the accounts. These will not show up on
their own:

- ssh keys and `~/.ssh/config` — the keys live in the 1Password agent
  (`IdentityAgent`), and the same agent signs commits (`op-ssh-sign` in
  `gitconfig`)
- logins: `gh auth login`, `glab auth login`, `atuin login`, claude, codex
- tokens: `~/.npmrc` (npmjs + npm.pkg.github.com), plus
  `CODEX_GITHUB_PERSONAL_ACCESS_TOKEN` and `YANDEX_TRACKER_MCP_TOKEN` in
  `.zshrc` — those belong in 1Password, not in plain text
- `~/.kube`, `~/.docker` and the rest of the client state
- the first launch of Docker Desktop and 1Password — they will ask for system
  permissions

To check that everything lined up: `mise bootstrap status` — every line there
should read `installed`/`applied`.

## Commands

```sh
make install     # mise + mise bootstrap --yes
make bootstrap   # mise bootstrap --yes
make upgrade     # mise upgrade
make lint        # actionlint + stylua --check on the nvim config

mise bootstrap --dry-run     # see what would change
mise bootstrap status        # state of every declarative part
mise bootstrap --only tools  # apply just one part
```

The Makefile exists for exactly two things: to install mise itself and to give
short names to its commands. There is no install logic in it.

CI ([`.github/workflows/main.yml`](.github/workflows/main.yml)) runs the same
checks on `macos-latest`: `mise bootstrap --dry-run`, then `actionlint` and
`stylua --check` over `nvim/lua`.

## What lives where

| `mise.toml` section | What it describes |
|---|---|
| `[tools]` | Languages and CLI utilities. Backends: registry, `npm:`, `gem:`, `pipx:`, `github:` |
| `[bootstrap.packages]` | System packages and GUI apps. `brew:`/`brew-cask:` are installed by mise through Homebrew itself |
| `[bootstrap.repos]` | Git repos (the you-should-use plugin) |
| `[dotfiles]` | Symlinks (`~/.config/nvim`, `~/.config/mise/config.toml`, `~/.gitconfig`), the `useful.zsh` snippet for oh-my-zsh and the managed lines in `.zshrc` (`mise-path`, `atuin`, `brew`, `yc`) |
| `[bootstrap.mise_shell_activate]` | The `mise activate` block in `.zshrc`, between markers |
| `[bootstrap.user]` | Login shell |
| `[bootstrap.hooks.pre-packages]` | Installs Homebrew on macOS before the `brew:` packages |
| `[bootstrap.hooks.pre-repos]` | Installs oh-my-zsh before its plugins get cloned |
| `[bootstrap.hooks.post-tools]` | Installs `yc` from the vendor script |
| `[tasks.bootstrap]` | `omz plugin enable` — the only thing left imperative |

`mise.toml` is symlinked into `~/.config/mise/config.toml`, so the tools are
global and available from any directory. But `mise bootstrap` has to be run
**from `~/dotfiles`**: the sources in `[dotfiles]` are relative, and mise
resolves them against whichever config file it loaded through — from the home
directory that is `~/.config/mise/`, and every source "disappears". Absolute
paths do not help here: then CI breaks, where the repo does not live in
`~/dotfiles`.

To add a tool — a line in `[tools]`, then `mise install`.
To add a system package — `mise bootstrap packages use brew:foo`.
To pull a changed dotfile into the repo — `mise bootstrap dotfiles add ~/.foo`.
To see what is actually installed right now — `mise ls`.

The repository is public, so `dotfiles add` is the one place a secret could leak
in here: the command copies the whole file. Look at what actually arrived before
committing. Tokens and keys are not kept here and must not be — they belong in
1Password. The only sensitive-looking thing in `gitconfig` is `user.signingkey`,
and that is the **public** half of an ssh key, exactly the one already sitting at
<https://github.com/mokevnin.keys>.

## VIM

[LazyVim](https://www.lazyvim.org/), config in `nvim/`.

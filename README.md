# dotfiles

The whole machine is described declaratively in a single file — [`mise.toml`](mise.toml).
macOS only.
It is applied by [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): system
packages, git repos, dotfile symlinks, login shell and tools.

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

`make install` = install Homebrew, install mise with it, and run `mise bootstrap
--yes`. Nothing has to be on the machine beforehand. Run it **from
`~/dotfiles`** — why, is explained below in "What lives where". The `--yes` flag
is also what keeps mise from asking whether you trust the config.

What happens, in order:

| | |
|---|---|
| `brew` target | installs Homebrew if it is missing — **asks for a password** |
| `mise` target | `brew install mise` |
| `pre-packages` hook | the same Homebrew installer, for the case where bootstrap is run without the Makefile. Here brew already exists, so it does nothing |
| `[bootstrap.packages]` | brew formulae and casks, GUI apps included. `pkg` casks (`docker-desktop`, `zoom`, `nordvpn`) go through `installer(8)` and **ask for a password** |
| `[bootstrap.repos]` | clones oh-my-zsh — only its plugin files are used |
| `[dotfiles]` | symlinks `~/.config/nvim`, `~/.config/mise/config.toml`, `~/.gitconfig`, `~/.config/starship.toml`, `~/.config/zsh/rc.zsh`, and writes the one line of `.zshrc` that sources the last of them |
| `[bootstrap.user]` | login shell set to `/bin/zsh` — **asks for a password** |
| `mise install` | the whole toolset, `yc` included. The longest part |

If mise is already on the machine, steps 3–4 collapse into a single command:

```sh
mise bootstrap --from https://github.com/mokevnin/dotfiles.git --from-dir ~/dotfiles --yes
```

### 5. A new shell

```sh
exec zsh
```

Until then none of this exists in the current session — `.zshrc` was written
after it had already started.

### What is left to do by hand

The repo describes the machine, but not the accounts. These will not show up on
their own:

- ssh keys and `~/.ssh/config` — the keys live in the 1Password agent
  (`IdentityAgent`), and the same agent signs commits (`op-ssh-sign` in
  `.gitconfig`)
- logins: `gh auth login`, `glab auth login`, `atuin login`, claude, codex
- tokens: `~/.npmrc` (npmjs + npm.pkg.github.com), plus
  `CODEX_GITHUB_PERSONAL_ACCESS_TOKEN` and `YANDEX_TRACKER_MCP_TOKEN` in
  `~/.config/zsh/local.zsh` — the one shell file that is deliberately untracked,
  sourced last by `rc.zsh`. This repo is public, so nothing secret can live in
  it; `local.zsh` is where those exports go instead
- `~/.kube`, `~/.docker` and the rest of the client state
- the first launch of Docker Desktop and 1Password — they will ask for system
  permissions

To check that everything lined up: `mise bootstrap status` — every line there
should read `installed`/`applied`. That covers the declarative parts only; the
hand-made half of this list is checked by `mise doctor project`, which probes
the logins, the 1Password ssh agent and the npm tokens and prints a hint for
whatever is still missing.

## Commands

```sh
make install                 # the only thing make is for: brew, then mise, then bootstrap

mise bootstrap --yes         # apply the config
mise bootstrap --dry-run     # see what would change
mise bootstrap status        # state of every declarative part
mise bootstrap --only tools  # apply just one part
mise upgrade                 # update the tools
mise run lint                # actionlint + stylua over the nvim config
mise doctor project          # check the logins, keys and tokens done by hand
```

The Makefile exists for exactly two things: installing Homebrew and installing
mise with it — the only pieces that cannot install themselves. Everything else
is a mise command.

CI ([`.github/workflows/main.yml`](.github/workflows/main.yml)) runs
`mise bootstrap --dry-run` on `macos-latest` and then the very same
`mise run lint`, so the lint is described in one place and not duplicated in the
workflow.

## The shell

`~/.zshrc` is generated and holds exactly one line — it sources
[`zsh/rc.zsh`](zsh/rc.zsh), where the whole config lives, ordering included.
mise creates `.zshrc` itself when it is missing, so nothing has to put one on a
fresh machine: zsh is already the macOS default.

There is no oh-my-zsh framework here, but its plugins are still used. `git`,
`vi-mode` and `eza` are ordinary zsh scripts and get sourced straight out of the
clone — the git aliases (`gst`, `gd`, `gpra`, ...) come from upstream and are not
retyped here. What is skipped is everything around them: themes, `plugins=()`,
`oh-my-zsh.sh`, the updater. That was most of the startup time and none of the
value; the prompt is [starship](starship.toml) instead, configured to look like
the `robbyrussell` theme it replaced.

The tradeoff is that `plugins/<name>/<name>.plugin.zsh` is an internal path
rather than a promised interface, and `[bootstrap.repos]` tracks `master`. If an
upstream change ever breaks a plugin, pin `ref` to a tag.

## What lives where

| `mise.toml` section | What it describes |
|---|---|
| `[tools]` | Languages and CLI utilities. Backends: registry, `npm:`, `gem:`, `pipx:`, `github:`, `http:` |
| `[bootstrap.packages]` | System packages and GUI apps. `brew:`/`brew-cask:` are installed by mise through Homebrew itself |
| `[bootstrap.repos]` | The oh-my-zsh clone, for its plugin files |
| `[dotfiles]` | Symlinks (`~/.config/nvim`, `~/.config/mise/config.toml`, `~/.gitconfig`, `~/.config/starship.toml`, `~/.config/zsh/rc.zsh`) and the single `source` line in `.zshrc` |
| `[bootstrap.user]` | Login shell |
| `[bootstrap.hooks.pre-packages]` | Installs Homebrew on macOS before the `brew:` packages |
| `[doctor.checks.*]` | Probes for the accounts the repo cannot install — run by `mise doctor project` |
| `[tasks.lint]` | `actionlint` + `stylua`, the same task locally and in CI |

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
1Password. The only sensitive-looking thing in `.gitconfig` is `user.signingkey`,
and that is the **public** half of an ssh key, exactly the one already sitting at
<https://github.com/mokevnin.keys>.

## VIM

[LazyVim](https://www.lazyvim.org/), config in `nvim/`.

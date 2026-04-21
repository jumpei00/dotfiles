# dotfiles

Personal development environment settings.

## Prerequisites

Install these tools via Homebrew before applying the configs:

```sh
# Core runtime tools
brew install neovim tmux lazydocker gh

# Nerd Font (required for Ghostty + Neovim icons)
brew install --cask font-jetbrains-mono-nerd-font

# Optional: database clients for vim-dadbod
brew install mysql-client     # for MySQL connections
brew install postgresql       # for PostgreSQL connections (provides psql)
```

Install separately (not via Homebrew):

- **Ghostty** — https://ghostty.org/
- **Claude Code** — https://docs.claude.com/en/docs/claude-code
- Run `gh auth login` once after installing `gh`.

Neovim LSP servers are auto-installed on first launch by `mason.nvim` (`nvim/lua/plugins/lsp.lua`). Language runtimes for those servers (`node`, `go`, `python`, etc.) need to be present on `PATH` separately.

## Neovim

The Neovim configuration lives in `nvim/`.

To use it on a machine:

```sh
mv ~/.config/nvim ~/.config/nvim.backup   # optional backup
ln -s "$HOME/dotfiles/nvim" ~/.config/nvim
```

Plugin versions are pinned by `nvim/lazy-lock.json`.

## Ghostty

The Ghostty configuration lives in `ghostty/`. Uses `JetBrainsMono Nerd Font` — install with:

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

To use it on a machine:

```sh
mkdir -p ~/.config/ghostty
ln -s "$HOME/dotfiles/ghostty/config" ~/.config/ghostty/config
```

## tmux

The tmux configuration lives in `tmux/`.

To use it on a machine:

```sh
mkdir -p ~/.config/tmux
ln -s "$HOME/dotfiles/tmux/tmux.conf" ~/.config/tmux/tmux.conf
```

## Claude Code scripts

Worktree helper scripts for Claude Code live in `claude/scripts/`.

- `cw [-r|-c] [worktree-name]` — opens a tmux window for the current repo, split into `vi .` (left, 2/3) and Claude Code (right, 1/3). Must be run inside a git repo.
  - Session name = repo basename (so all invocations within the same repo group into one session).
  - Window name = worktree name, or `main` when no arg is given.
  - `cw <name>` — window `<name>`, left in `<repo>/.claude/worktrees/<name>`, right runs `claude -w <name>`.
  - `cw` (no args) — window `main`, left in repo root, right runs `claude`.
  - `-r` — launches Claude with `-r` (resume picker for past sessions).
  - `-c` — launches Claude with `-c` (continue most recent session).
  - If the window already exists, switches to it instead of recreating (resume/continue flags are ignored since Claude is already running).

Inside tmux, two keybindings spawn new worktree windows without leaving the current session:

- `Ctrl-b N` — prompts for a worktree name, runs `cw <name>` (fresh Claude).
- `Ctrl-b R` — prompts for a worktree name, runs `cw -r <name>` (resume picker).

To use them on a machine:

```sh
mkdir -p ~/.claude/scripts
ln -s "$HOME/dotfiles/claude/scripts/cw" ~/.claude/scripts/cw
```

Then add to `~/.zshrc`:

```sh
alias cw="$HOME/.claude/scripts/cw"
```

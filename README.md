# dotfiles

個人用の開発環境設定です。Neovim、tmux、Ghostty、Herdr、Claude Code/Codex 用の worktree ランチャーを管理します。

## 対象環境

- macOS
- Homebrew
- zsh
- GitHub CLI を使う前提の GitHub 開発環境

## セットアップ

新しいmacOS環境では、リポジトリを`~/dotfiles`へ配置して次のコマンドを実行します。Homebrew、基盤ツール、言語runtime、formatter、AIツール、設定ファイルのリンク、Neovimの初期構築までまとめて行います。

```sh
cd ~/dotfiles
make setup
```

AIツールとHerdr integrationを導入しない場合:

```sh
make setup-no-ai
```

利用できる処理を確認する場合:

```sh
make help
```

既存の設定ファイルがある場合、`make links`は削除せず`*.backup-YYYYMMDDhhmmss`へ退避してからsymlinkを作成します。依存ツールのインストール内容だけを事前確認する場合は`./scripts/install-deps --dry-run`を使います。

インストール後に必要な認証:

```sh
gh auth login
codex login
```

Claude Code は初回起動時にログインしてください。

## インストール対象

このリポジトリの設定から検出した外部依存です。

### 基本ツール

| ツール | 用途 | インストール |
|---|---|---|
| Homebrew | パッケージ管理 | `scripts/install-deps` が未導入時にインストール |
| mise | 言語runtime・formatter・開発CLIのバージョン管理 | `brew install mise` |
| Ghostty | ターミナル | `brew install --cask ghostty` |
| JetBrainsMono Nerd Font | Ghostty/Neovim のアイコン表示 | `brew install --cask font-jetbrains-mono-nerd-font` |
| Neovim | エディタ | `brew install neovim` |
| tmux | 既存の pane/window/session 管理 | `brew install tmux` |
| Herdr | AI agent 向け terminal workspace manager | `brew install herdr` |
| GitHub CLI | Neovim の PR review helper、GitHub 操作 | `brew install gh` |
| lazydocker | Neovim から Docker UI を開く | `brew install lazydocker` |
| jq | Herdr launcher の JSON 処理 | `brew install jq` |
| ripgrep | Telescope `live_grep` | `brew install ripgrep` |
| mysql-client | vim-dadbod から MySQL 接続 | `brew install mysql-client` |
| postgresql | vim-dadbod から PostgreSQL 接続、`psql` | `brew install postgresql` |

### AI エージェント

| ツール | 用途 | インストール |
|---|---|---|
| Claude Code | 仕事用 AI agent、`cct`/`cch` | `npm install -g @anthropic-ai/claude-code` |
| Codex CLI | Codex agent、`cdt`/`cdh` | `brew install --cask codex` |
| Herdr Claude integration | Herdr の agent panel/notification | `herdr integration install claude` |
| Herdr Codex integration | Herdr の agent panel/notification | `herdr integration install codex` |

### miseが管理する言語runtime・開発CLI

定義は[mise/config.toml](./mise/config.toml)にあります。グローバルのデフォルトとして使い、各プロジェクトの`mise.toml`で上書きできます。

| ツール | 用途 |
|---|---|
| Node.js/npm | JavaScript・TypeScriptとnpm backendの実行環境 |
| Go | Go開発、`gofmt`、Go backendの実行環境 |
| Python / uv | Python開発とパッケージ管理 |
| Ruby | Ruby開発 |
| Java / Kotlin | JVM・Kotlin開発 |
| Zig | Zig開発、`zig fmt` |
| Terraform | Terraform CLI、`terraform fmt` |
| Biome | 必要に応じて利用するJS/TS toolchain。Neovimの標準formatterには未使用 |

### Neovim の外部 formatter / CLI

[nvim/lua/plugins/format.lua](./nvim/lua/plugins/format.lua) から検出したものです。

| CLI | 対象 |
|---|---|
| `stylua` | Lua |
| `gofmt` | Go |
| `goimports` | Go |
| `prettier` | JavaScript, TypeScript, React, JSON, YAML, Markdown |
| `ruff` | Python formatter |
| `zigfmt` | Zig |
| `dockerfmt` | Dockerfile |
| `sql-formatter` | SQL |
| `terraform` | Terraform (`terraform fmt`) |

formatter CLIはmiseがインストールし、Conformはfiletypeとの対応付けだけを行います。標準のJS/TS系formatterはPrettierです。Biomeもインストールしますが、自動formatには割り当てていません。

### Neovim の LSP / parser

[nvim/lua/plugins/lsp.lua](./nvim/lua/plugins/lsp.lua) では Mason 経由で次の LSP を入れます。

- `gopls`
- `ts_ls`
- `lua_ls`
- `jsonls`
- `yamlls`
- `dockerls`
- `zls`
- `pyright`
- `ruby_lsp`
- `jdtls`
- `kotlin_lsp`
- `terraformls`

[nvim/lua/plugins/treesitter.lua](./nvim/lua/plugins/treesitter.lua) では次の Treesitter parser を入れます。

- Go
- Java
- JavaScript
- Kotlin
- Lua
- Python
- Query
- TSX
- TypeScript
- Vim
- Vimdoc

LSP serverはMasonが管理します。`kotlin_lsp`の`intellij-server`もMasonのbinから起動します。

## 設定ファイルのリンク

通常は`make setup`に含まれるため、個別に作業する必要はありません。リンクだけを作成・更新する場合は次を実行します。

```sh
make links
```

### mise

```sh
mkdir -p ~/.config
ln -s "$HOME/dotfiles/mise" ~/.config/mise
mise install
```

`mise.lock`もこのリポジトリで管理します。

### zsh

```sh
ln -s "$HOME/dotfiles/zsh/zshrc" ~/.zshrc
```

HomebrewやOrbStackのPATH設定後、最後にmiseを有効化します。

### Neovim

```sh
mkdir -p ~/.config
ln -s "$HOME/dotfiles/nvim" ~/.config/nvim
```

初回起動時に `lazy.nvim`、Mason LSP server、Treesitter parser が入ります。

### Ghostty

```sh
mkdir -p ~/.config/ghostty
ln -s "$HOME/dotfiles/ghostty/config" ~/.config/ghostty/config
```

### tmux

```sh
mkdir -p ~/.config/tmux
ln -s "$HOME/dotfiles/tmux/tmux.conf" ~/.config/tmux/tmux.conf
```

tmux prefix は `Ctrl-q` です。

- `Ctrl-q h/j/k/l` - pane 移動
- `Ctrl-q N` - Claude Code 用 worktree window を作成
- `Ctrl-q R` - Claude Code 用 worktree window を resume 付きで作成

### Herdr

```sh
mkdir -p ~/.config/herdr
ln -s "$HOME/dotfiles/herdr/config.toml" ~/.config/herdr/config.toml
```

Herdr も prefix は `Ctrl-q` です。

- `Ctrl-q h/j/k/l` - pane 移動
- `Ctrl-q w` - workspace picker
- `Ctrl-q K/J` - 前/次の workspace に移動
- `Ctrl-q 1..9` - workspace 番号へ移動
- `Ctrl-q n/p` - 次/前の tab に移動
- `Ctrl-q b` - sidebar/agent panel 切り替え
- `Ctrl-q Alt-n` - Claude Code + Herdr workspace を作成
- `Ctrl-q Alt-r` - Claude Code + Herdr workspace を resume 付きで作成
- `Ctrl-q Alt-x` - Codex + Herdr workspace を作成
- `Ctrl-q Alt-z` - Codex + Herdr workspace を resume 付きで作成

## Agent worktree ランチャー

4 パターンのランチャーを用意しています。

| コマンド | Agent | UI |
|---|---|---|
| `cct` | Claude Code | tmux |
| `cch` | Claude Code | Herdr |
| `cdt` | Codex | tmux |
| `cdh` | Codex | Herdr |

使い方:

```sh
cct             # repo root を main として開く
cct feature-a   # .claude/worktrees/feature-a を作成/利用
cch feature-a   # Claude Code + Herdr
cdt feature-a   # Codex + tmux
cdh feature-a   # Codex + Herdr
```

resume:

```sh
cct -r feature-a
cch -r feature-a
cdt -r feature-a
cdh -r feature-a
```

continue:

```sh
cct -c feature-a
cch -c feature-a
cdt -c feature-a
cdh -c feature-a
```

worktree の置き場:

- Claude Code: `<repo>/.claude/worktrees/<name>`
- Codex: `<repo>/.codex/worktrees/<name>`

`main` は worktree を作らず repo root を使います。

tmux session / Herdr session は repo 名で作成します。window / workspace は worktree 名です。

tmux は1 window内に左ペインでNeovim、右ペインでAgentを起動します。Herdrは1 workspace内に2 tabを作り、`nvim` tabでNeovim、`claude`または`codex` tabでAgentを起動します。Herdr起動直後は`nvim` tabを表示し、`Ctrl-q n` / `Ctrl-q p`でAgent tabとの間を移動できます。

Herdrでは、どのworkspaceから新しいworkspaceを作成してもmain repoを基準にします。Claudeのworktreeは`<main-repo>/.claude/worktrees/<name>`、Codexのworktreeは`<main-repo>/.codex/worktrees/<name>`に作成され、同じrepo名のHerdr sessionへworkspaceが追加されます。

Claude Code は `claude -w <name>` の worktree 作成機能に任せます。Codex には同等の worktree 作成機能がないため、launcher が `.codex/worktrees/<name>` を `git worktree add` で作成してから `codex -C <path>` を起動します。

既に同名の window / workspace がある場合は、agent を起動し直さずそこへ移動します。同じ worktree で別 agent を使いたい場合は、その workspace / window 内で手動で pane を開いて起動してください。

## zsh alias

`cct`、`cch`、`cdt`、`cdh`は[zsh/zshrc](./zsh/zshrc)で定義します。

Herdr custom command は `~/.zshrc` の alias に依存せず、dotfiles 内の script を直接呼びます。

## 補足

- `gh auth login` は Neovim の PR review helper を使う前に必要です。
- Neovim plugin のバージョンは [nvim/lazy-lock.json](./nvim/lazy-lock.json) で固定しています。
- 言語runtimeとformatterの実バージョンはmiseで管理し、プロジェクト固有のバージョンは各repoの`mise.toml`で上書きします。
- `make setup`は依存ツールの導入、symlink作成、Neovim初期構築、検証を順番に行います。
- `scripts/install-deps`は依存ツールのインストールだけを行い、既存設定ファイルは変更しません。
- `scripts/link-config`は既存設定をバックアップしてからsymlinkを作成します。

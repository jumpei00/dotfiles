SHELL := /bin/bash
.DEFAULT_GOAL := help

REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
MISE_ENV := env MISE_GLOBAL_CONFIG_FILE="$(REPO_ROOT)/mise/config.toml"
MASON_PACKAGES := dockerfile-language-server gopls jdtls json-lsp kotlin-lsp lua-language-server pyright ruby-lsp terraform-ls typescript-language-server yaml-language-server zls

.PHONY: help setup setup-no-ai install install-no-ai links nvim-bootstrap verify mise-lock

help: ## 利用できるターゲットを表示する
	@awk 'BEGIN { FS = ":.*## " } /^[a-zA-Z0-9_-]+:.*## / { printf "  %-16s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

setup: install links nvim-bootstrap verify ## AIツールを含む開発環境を一括構築する

setup-no-ai: install-no-ai links nvim-bootstrap verify ## AIツールを除いて開発環境を一括構築する

install: ## Homebrew、mise、AIツールをインストールする
	./scripts/install-deps

install-no-ai: ## AIツールを除いて依存ツールをインストールする
	./scripts/install-deps --skip-ai

links: ## dotfilesの設定をホームディレクトリへリンクする
	./scripts/link-config

nvim-bootstrap: ## Neovimプラグイン、LSP、parserをインストールする
	$(MISE_ENV) mise exec -- nvim --headless "+Lazy! restore" "+qa"
	$(MISE_ENV) mise exec -- nvim --headless "+MasonInstall $(MASON_PACKAGES)" "+qa"
	$(MISE_ENV) mise exec -- nvim --headless "+lua require('nvim-treesitter').install({ 'go', 'java', 'javascript', 'kotlin', 'lua', 'python', 'query', 'tsx', 'typescript', 'vim', 'vimdoc' }):wait(300000)" "+qa"

verify: ## 設定と主要コマンドを検証する
	bash -n scripts/install-deps scripts/link-config
	zsh -n zsh/zshrc
	$(MISE_ENV) mise exec -- bash -c 'for command in node npm go goimports python uv ruby java kotlin zig terraform prettier biome ruff stylua dockerfmt sql-formatter; do command -v "$$command" >/dev/null || { echo "missing: $$command" >&2; exit 1; }; done'
	@echo "verification passed"

mise-lock: ## mise.lockを現在の設定から更新する
	$(MISE_ENV) mise lock --global --yes

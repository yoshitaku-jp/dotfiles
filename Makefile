.PHONY: setup clean update brew

# 環境セットアップ
setup:
	@echo "Starting dotfiles setup..."
	@chmod +x setup.sh install_brew.sh setup_links.sh
	@./setup.sh
	@echo "Dotfiles setup completed!"

# Homebrew でパッケージをインストール
brew:
	@echo "Installing packages from Brewfile..."
	@brew bundle --file=Brewfile

# クリーンアップ (シンボリックリンクを削除)
clean:
	@echo "Removing symlinks..."
	@rm -f ~/.zshrc
	@rm -rf ~/.zsh
	@echo "Cleanup completed!"

# dotfiles を最新の状態に更新
update:
	@git pull --rebase
	@make setup

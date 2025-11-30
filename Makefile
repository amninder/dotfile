# Makefile for dotfile configuration setup

# Python packages to install via Homebrew
PYTHON_PKGS := \
	python-lsp-server \
	virtualenvwrapper

# Install Python development tools
install-python:
	@echo "Installing Python packages..."
	@for pkg in $(PYTHON_PKGS); do \
		echo "Installing $$pkg..."; \
		brew install $$pkg || true; \
	done
	@echo "Python packages installation complete!"

# Install and update Neovim plugins
install-nvim-plugins:
	@echo "Installing and updating Neovim plugins..."
	nvim --headless "+Lazy! sync" +qa
	@echo "Neovim plugins installation complete!"

# Install all dependencies
install: install-python install-nvim-plugins

# Display help information
help:
	@echo "Available targets:"
	@echo "  install-python       - Install Python development tools"
	@echo "  install-nvim-plugins - Install and update Neovim plugins"
	@echo "  install              - Install all dependencies"
	@echo "  help                 - Display this help message"

.PHONY: install-python install-nvim-plugins install help

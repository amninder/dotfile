.PHONY: install-nvim install-nvim-plugins update clean backup install-fonts install-brew install-python install-dev-tools link link-nvim clean-nvim purge-nvim test-nerd-fonts test-smoke test-unicode test-icons test-all install-zsh zsh-init clean-zsh install-oh-my-zsh clean-oh-my-zsh install-tmux install-tpm install-tmux-powerline clean-tmux clean-tmux-powerline link-gitconfig clean-gitconfig help

NVIM_DIR := $(HOME)/.config/nvim
BACKUP_DIR := $(HOME)/.config/nvim-backup-$(shell date +%Y%m%d-%H%M%S)

# Detect OS
UNAME_S := $(shell uname -s)

# Default Nerd Fonts to install (can be overridden)
NERD_FONTS ?= font-jetbrains-mono-nerd-font font-fira-code-nerd-font font-hack-nerd-font font-meslo-lg-nerd-font

# Python packages to install via Homebrew
PYTHON_PKGS := \
	python-lsp-server \
	virtualenvwrapper

# Development tools to install via Homebrew
DEV_TOOLS := \
	terraform-ls \
	typescript-language-server

# Color printing function
define print_colored
@_msg=$(1); \
_color=$(if $(2),$(2),green); \
case $$_color in \
	red) printf '\033[1;31m%s\033[0m\n' "$$_msg" ;; \
	green) printf '\033[1;32m%s\033[0m\n' "$$_msg" ;; \
	yellow) printf '\033[1;33m%s\033[0m\n' "$$_msg" ;; \
	cyan) printf '\033[1;36m%s\033[0m\n' "$$_msg" ;; \
	blue) printf '\033[1;34m%s\033[0m\n' "$$_msg" ;; \
	plain) printf '%s\n' "$$_msg" ;; \
	*) printf '\033[1;32m%s\033[0m\n' "$$_msg" ;; \
esac
endef

# Help menu item printing function (bold command + white description)
define print_help_item
@_cmd=$(1); \
_desc=$(2); \
_color=$(if $(3),$(3),default); \
case $$_color in \
	red) printf '\033[1;31m%-25s\033[0m%s\n' "$$_cmd" "$$_desc" ;; \
	*) printf '\033[1m%-25s\033[0m%s\n' "$$_cmd" "$$_desc" ;; \
esac
endef

help:
	@$(call print_colored,"Neovim Configuration Management","cyan")
	@$(call print_colored,"================================","cyan")
	@$(call print_help_item,"install-nvim","- Install Neovim (macOS: via brew)")
	@printf '  \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"install-nvim-plugins","- Install/sync all plugins via lazy.nvim")
	@printf '  \033[2m└─ install-nvim\033[0m\n'
	@printf '     \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"update","- Update all plugins to latest versions")
	@$(call print_help_item,"clean","- Clean plugin cache and unused plugins")
	@printf '  \033[2m├─ clean-zsh\033[0m\n'
	@printf '  \033[2m├─ clean-oh-my-zsh\033[0m\n'
	@printf '  \033[2m├─ clean-tmux\033[0m\n'
	@printf '  \033[2m└─ clean-gitconfig\033[0m\n'
	@$(call print_help_item,"backup","- Backup current configuration")
	@$(call print_help_item,"link","- Create all configuration symlinks")
	@printf '  \033[2m├─ link-nvim\033[0m\n'
	@printf '  \033[2m└─ link-gitconfig\033[0m\n'
	@$(call print_help_item,"link-nvim","- Create symlink for ~/.config/nvim (requires nvim)")
	@$(call print_help_item,"link-gitconfig","- Create symlink for ~/.gitconfig")
	@$(call print_help_item,"clean-nvim","- Remove ~/.config/nvim symlink (safe)")
	@$(call print_help_item,"clean-gitconfig","- Remove ~/.gitconfig symlink (safe)")
	@$(call print_help_item,"purge-nvim","- Complete removal of Neovim and all data","red")
	@$(call print_help_item,"install-fonts","- Install Nerd Fonts (macOS: via brew)")
	@printf '  \033[2m└─ install-brew\033[0m\n'
	@echo ""
	@$(call print_colored,"Testing:","yellow")
	@$(call print_help_item,"test-nerd-fonts","- Run smoke test for basic Nerd Font icons")
	@printf '  \033[2m└─ test-smoke\033[0m\n'
	@$(call print_help_item,"test-smoke","- Run basic smoke test")
	@$(call print_help_item,"test-unicode","- Test Unicode ranges with hex codes (comprehensive)")
	@$(call print_help_item,"test-icons","- Test all icon sets (comprehensive, categorized)")
	@$(call print_help_item,"test-all","- Run all Nerd Font tests")
	@echo ""
	@$(call print_colored,"System Tools:","yellow")
	@$(call print_help_item,"install-brew","- Install Homebrew (macOS only)")
	@$(call print_help_item,"install-python","- Install Python development tools via Homebrew")
	@printf '  \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"install-dev-tools","- Install development tools (terraform-ls and typescript-language-server)")
	@printf '  \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"install-zsh","- Install Zsh shell (multi-OS support)")
	@printf '  \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"zsh-init","- Install Zsh and create ~/.zshrc symlink")
	@printf '  \033[2m└─ install-zsh\033[0m\n'
	@printf '     \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"clean-zsh","- Remove ~/.zshrc symlink (safe)")
	@$(call print_help_item,"install-oh-my-zsh","- Install Oh My Zsh framework")
	@printf '  \033[2m└─ install-zsh\033[0m\n'
	@printf '     \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"clean-oh-my-zsh","- Uninstall Oh My Zsh completely")
	@$(call print_help_item,"install-tmux","- Install tmux and create ~/.tmux.conf symlink")
	@printf '  \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"install-tpm","- Install TPM (Tmux Plugin Manager)")
	@printf '  \033[2m└─ install-tmux\033[0m\n'
	@printf '     \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"install-tmux-powerline","- Configure tmux-powerline with gruvbox theme")
	@printf '  \033[2m└─ install-tpm\033[0m\n'
	@printf '     \033[2m└─ install-tmux\033[0m\n'
	@printf '        \033[2m└─ install-brew\033[0m\n'
	@$(call print_help_item,"clean-tmux-powerline","- Remove tmux-powerline config symlink (safe)")
	@$(call print_help_item,"clean-tmux","- Uninstall tmux and remove configuration","red")
	@echo ""
	@$(call print_colored,"Environment Variables:","yellow")
	@$(call print_colored,"  NERD_FONTS   - Space-separated list of fonts to install","cyan")
	@$(call print_colored,"                 Default: JetBrains Mono | Fira Code | Hack | Meslo LG","plain")
	@$(call print_colored,"  PYTHON_PKGS  - Python packages to install","cyan")
	@$(call print_colored,"                 Default: python-lsp-server | virtualenvwrapper","plain")

install-nvim: install-brew
ifeq ($(UNAME_S),Darwin)
	@$(call print_colored,"Installing Neovim on macOS...")
	@if command -v nvim >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "✓ Neovim already installed"; \
		nvim --version | head -1; \
	else \
		brew install neovim; \
		printf "\033[1;32m%s\033[0m\n" "✓ Neovim installed successfully"; \
	fi
	@$(call print_colored,"Setting up configuration symlink...")
	@mkdir -p $(HOME)/.config
	@if [ -L $(NVIM_DIR) ]; then \
		current_target=$$(readlink $(NVIM_DIR)); \
		if [ "$$current_target" = "$(CURDIR)" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink already exists: $(NVIM_DIR) -> $(CURDIR)"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink exists but points to: $$current_target"; \
		fi \
	elif [ -e $(NVIM_DIR) ]; then \
		backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Backing up existing config to $$backup_dir..."; \
		mv $(NVIM_DIR) $$backup_dir; \
		ln -s $(CURDIR) $(NVIM_DIR); \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"; \
	else \
		ln -s $(CURDIR) $(NVIM_DIR); \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"; \
	fi
else
	@$(call print_colored,"⚠ Please install Neovim manually on $(UNAME_S)","red")
	@$(call print_colored,"  Visit: https://github.com/neovim/neovim/wiki/Installing-Neovim","plain")
endif

install-nvim-plugins: install-nvim
	@$(call print_colored,"Installing/syncing Neovim plugins...")
	@nvim --headless "+Lazy! sync" +qa 2>&1 | grep -v -E "(Not an editor command|Error detected while processing)" || true
	@$(call print_colored,"✓ Plugins installed successfully")

update:
	@$(call print_colored,"Updating Neovim plugins...")
	@nvim --headless "+Lazy! update" +qa 2>&1 | grep -v -E "(Not an editor command|Error detected while processing)" || true
	@$(call print_colored,"✓ Plugins updated successfully")

clean: clean-zsh clean-oh-my-zsh clean-tmux clean-tmux-powerline clean-gitconfig
	@$(call print_colored,"Cleaning plugin cache...")
	@nvim --headless "+Lazy! clean" +qa 2>&1 | grep -v -E "(Not an editor command|Error detected while processing)" || true
	@$(call print_colored,"✓ Cache cleaned successfully")

backup:
	@$(call print_colored,"Backing up configuration to $(BACKUP_DIR)...")
	@cp -r $(NVIM_DIR) $(BACKUP_DIR)
	@$(call print_colored,"✓ Backup created at $(BACKUP_DIR)")

link: link-nvim link-gitconfig
	@$(call print_colored,"✓ All symlinks created successfully","green")

link-nvim:
	@$(call print_colored,"Verifying Neovim installation...")
	@if ! command -v nvim >/dev/null 2>&1; then \
		printf "\033[1;31m%s\033[0m\n" "✗ Neovim is not installed on the system"; \
		printf "\033[1;33m%s\033[0m\n" "⚠ Please install Neovim first using 'make install-nvim'"; \
		exit 1; \
	fi
	@printf "\033[1;32m%s\033[0m\n" "✓ Neovim is installed"
	@$(call print_colored,"Creating symlink to ~/.config/nvim...")
	@mkdir -p $(HOME)/.config
	@if [ -L $(NVIM_DIR) ]; then \
		current_target=$$(readlink $(NVIM_DIR)); \
		if [ "$$current_target" = "$(CURDIR)" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink already points to $(CURDIR)"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink exists but points to: $$current_target"; \
			backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Creating backup at $$backup_dir..."; \
			mv $(NVIM_DIR) $$backup_dir; \
			ln -s $(CURDIR) $(NVIM_DIR); \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"; \
		fi \
	elif [ -e $(NVIM_DIR) ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ $(NVIM_DIR) already exists"; \
		backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Creating backup at $$backup_dir..."; \
		mv $(NVIM_DIR) $$backup_dir; \
		ln -s $(CURDIR) $(NVIM_DIR); \
		printf "\033[1;32m%s\033[0m\n" "✓ Backup created at $$backup_dir"; \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"; \
	else \
		ln -s $(CURDIR) $(NVIM_DIR); \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"; \
	fi

link-gitconfig:
	@$(call print_colored,"Creating symlink for .gitconfig...")
	@if [ -L $(HOME)/.gitconfig ]; then \
		current_target=$$(readlink $(HOME)/.gitconfig); \
		if [ "$$current_target" = "$(CURDIR)/.gitconfig" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ .gitconfig symlink already points to $(CURDIR)/.gitconfig"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ .gitconfig symlink exists but points to: $$current_target"; \
			backup_file=$(HOME)/.gitconfig-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Creating backup at $$backup_file..."; \
			mv $(HOME)/.gitconfig $$backup_file; \
			ln -s $(CURDIR)/.gitconfig $(HOME)/.gitconfig; \
			printf "\033[1;32m%s\033[0m\n" "✓ .gitconfig symlink created: $(HOME)/.gitconfig -> $(CURDIR)/.gitconfig"; \
		fi \
	elif [ -e $(HOME)/.gitconfig ]; then \
		backup_file=$(HOME)/.gitconfig-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Backing up existing .gitconfig to $$backup_file..."; \
		mv $(HOME)/.gitconfig $$backup_file; \
		ln -s $(CURDIR)/.gitconfig $(HOME)/.gitconfig; \
		printf "\033[1;32m%s\033[0m\n" "✓ Backup created at $$backup_file"; \
		printf "\033[1;32m%s\033[0m\n" "✓ .gitconfig symlink created: $(HOME)/.gitconfig -> $(CURDIR)/.gitconfig"; \
	else \
		ln -s $(CURDIR)/.gitconfig $(HOME)/.gitconfig; \
		printf "\033[1;32m%s\033[0m\n" "✓ .gitconfig symlink created: $(HOME)/.gitconfig -> $(CURDIR)/.gitconfig"; \
	fi

clean-gitconfig:
	@$(call print_colored,"Removing .gitconfig symlink...")
	@if [ -L $(HOME)/.gitconfig ]; then \
		current_target=$$(readlink $(HOME)/.gitconfig); \
		if [ "$$current_target" = "$(CURDIR)/.gitconfig" ]; then \
			rm $(HOME)/.gitconfig; \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink removed: $(HOME)/.gitconfig"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink points to different location: $$current_target"; \
			printf "%s\n" "  Not removing to prevent data loss"; \
		fi \
	elif [ -e $(HOME)/.gitconfig ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ $(HOME)/.gitconfig exists but is not a symlink"; \
		printf "%s\n" "  Not removing to prevent data loss"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ No symlink found at $(HOME)/.gitconfig"; \
	fi

clean-nvim:
	@$(call print_colored,"Removing ~/.config/nvim symlink...")
	@if [ -L $(NVIM_DIR) ]; then \
		current_target=$$(readlink $(NVIM_DIR)); \
		if [ "$$current_target" = "$(CURDIR)" ]; then \
			rm $(NVIM_DIR); \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink removed: $(NVIM_DIR)"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink points to different location: $$current_target"; \
			printf "%s\n" "  Not removing to prevent data loss"; \
		fi \
	elif [ -e $(NVIM_DIR) ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ $(NVIM_DIR) exists but is not a symlink"; \
		printf "%s\n" "  Not removing to prevent data loss"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ No symlink found at $(NVIM_DIR)"; \
	fi

purge-nvim:
	@$(call print_colored,"⚠ WARNING: This will completely remove Neovim and all its data!","red")
	@$(call print_colored,"This includes:","red")
	@$(call print_colored,"  - Neovim installation (via brew)","plain")
	@$(call print_colored,"  - Configuration symlink (~/.config/nvim)","plain")
	@$(call print_colored,"  - Plugin data (~/.local/share/nvim)","plain")
	@$(call print_colored,"  - State/logs (~/.local/state/nvim)","plain")
	@$(call print_colored,"  - Cache (~/.cache/nvim)","plain")
	@echo ""
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		printf "%s\n" "Purging Neovim..."; \
		if command -v brew >/dev/null 2>&1; then \
			printf "%s\n" "Uninstalling Neovim via Homebrew..."; \
			brew uninstall neovim || printf "\033[1;33m%s\033[0m\n" "⚠ Neovim not installed via brew"; \
		fi; \
		if [ -L $(NVIM_DIR) ]; then \
			printf "%s\n" "Removing config symlink..."; \
			rm $(NVIM_DIR); \
		elif [ -d $(NVIM_DIR) ]; then \
			backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Backing up config to $$backup_dir..."; \
			mv $(NVIM_DIR) $$backup_dir; \
		fi; \
		printf "%s\n" "Removing data directory..."; \
		rm -rf $(HOME)/.local/share/nvim; \
		printf "%s\n" "Removing state directory..."; \
		rm -rf $(HOME)/.local/state/nvim; \
		printf "%s\n" "Removing cache directory..."; \
		rm -rf $(HOME)/.cache/nvim; \
		printf "\033[1;32m%s\033[0m\n" "✓ Neovim completely purged"; \
	else \
		printf "%s\n" "Purge cancelled"; \
	fi

install-brew:
ifeq ($(UNAME_S),Darwin)
	@if ! command -v brew >/dev/null 2>&1; then \
		printf "%s\n" "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		printf "\033[1;32m%s\033[0m\n" "✓ Homebrew installed successfully"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ Homebrew already installed"; \
	fi
else
	@$(call print_colored,"⚠ Homebrew installation is only supported on macOS","red")
endif

install-python: install-brew
	@$(call print_colored,"Installing Python development tools...")
	@for pkg in $(PYTHON_PKGS); do \
		printf "%s\n" "Installing $$pkg..."; \
		brew install $$pkg || printf "\033[1;33m%s\033[0m\n" "⚠ Failed to install $$pkg"; \
	done
	@$(call print_colored,"✓ Python packages installation complete")

install-dev-tools: install-brew
	@$(call print_colored,"Installing development tools...")
	@for tool in $(DEV_TOOLS); do \
		printf "%s\n" "Installing $$tool..."; \
		brew install $$tool || printf "\033[1;33m%s\033[0m\n" "⚠ Failed to install $$tool"; \
	done
	@$(call print_colored,"✓ Development tools installation complete")

install-zsh: install-brew
ifeq ($(UNAME_S),Darwin)
	@$(call print_colored,"Installing Zsh on macOS...")
	@if command -v zsh >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "✓ Zsh already installed"; \
		zsh --version; \
	else \
		brew install zsh; \
		printf "\033[1;32m%s\033[0m\n" "✓ Zsh installed successfully"; \
		zsh --version; \
	fi
else ifeq ($(UNAME_S),Linux)
	@$(call print_colored,"Installing Zsh on Linux...")
	@if command -v zsh >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "✓ Zsh already installed"; \
		zsh --version; \
	else \
		if [ -f /etc/os-release ]; then \
			. /etc/os-release; \
			case "$$ID" in \
				ubuntu|debian) \
					printf "%s\n" "Detected Debian/Ubuntu, using apt-get..."; \
					sudo apt-get update && sudo apt-get install -y zsh; \
					;; \
				rhel|centos|fedora) \
					printf "%s\n" "Detected RHEL/CentOS/Fedora..."; \
					if command -v dnf >/dev/null 2>&1; then \
						sudo dnf install -y zsh; \
					else \
						sudo yum install -y zsh; \
					fi; \
					;; \
				arch) \
					printf "%s\n" "Detected Arch Linux, using pacman..."; \
					sudo pacman -S --noconfirm zsh; \
					;; \
				*) \
					printf "\033[1;33m%s\033[0m\n" "⚠ Unknown distribution: $$ID"; \
					printf "%s\n" "  Please install zsh manually"; \
					exit 1; \
					;; \
			esac; \
			printf "\033[1;32m%s\033[0m\n" "✓ Zsh installed successfully"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Cannot detect distribution"; \
			printf "%s\n" "  Please install zsh manually"; \
			exit 1; \
		fi \
	fi
else
	@$(call print_colored,"⚠ Unsupported OS: $(UNAME_S)","red")
	@$(call print_colored,"  Please install Zsh manually","plain")
endif

zsh-init: install-zsh
	@$(call print_colored,"Initializing Zsh configuration...")
	@if command -v zsh >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "Found zsh"; \
	fi
	@$(call print_colored,"Creating symlink for .zshrc...")
	@if [ -L $(HOME)/.zshrc ]; then \
		current_target=$$(readlink $(HOME)/.zshrc); \
		if [ "$$current_target" = "$(CURDIR)/.zshrc" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink already points to $(CURDIR)/.zshrc"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink exists but points to: $$current_target"; \
			backup_file=$(HOME)/.zshrc-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Creating backup at $$backup_file..."; \
			mv $(HOME)/.zshrc $$backup_file; \
			ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc; \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(HOME)/.zshrc -> $(CURDIR)/.zshrc"; \
		fi \
	elif [ -e $(HOME)/.zshrc ]; then \
		backup_file=$(HOME)/.zshrc-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Backing up existing .zshrc to $$backup_file..."; \
		mv $(HOME)/.zshrc $$backup_file; \
		ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc; \
		printf "\033[1;32m%s\033[0m\n" "✓ Backup created at $$backup_file"; \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(HOME)/.zshrc -> $(CURDIR)/.zshrc"; \
	else \
		ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc; \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(HOME)/.zshrc -> $(CURDIR)/.zshrc"; \
	fi

clean-zsh:
	@$(call print_colored,"Removing .zshrc symlink...")
	@if [ -L $(HOME)/.zshrc ]; then \
		current_target=$$(readlink $(HOME)/.zshrc); \
		if [ "$$current_target" = "$(CURDIR)/.zshrc" ]; then \
			rm $(HOME)/.zshrc; \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink removed: $(HOME)/.zshrc"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink points to different location: $$current_target"; \
			printf "%s\n" "  Not removing to prevent data loss"; \
		fi \
	elif [ -e $(HOME)/.zshrc ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ $(HOME)/.zshrc exists but is not a symlink"; \
		printf "%s\n" "  Not removing to prevent data loss"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ No symlink found at $(HOME)/.zshrc"; \
	fi

install-oh-my-zsh: install-zsh
	@$(call print_colored,"Installing Oh My Zsh...")
	@if [ -d $(HOME)/.oh-my-zsh ]; then \
		printf "\033[1;32m%s\033[0m\n" "✓ Oh My Zsh already installed"; \
	else \
		printf "%s\n" "Downloading and installing Oh My Zsh..."; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; \
		printf "\033[1;32m%s\033[0m\n" "✓ Oh My Zsh installed successfully"; \
	fi
	@$(call print_colored,"Setting up gentoo2 theme symlink...")
	@if [ -L $(HOME)/.oh-my-zsh/themes/gentoo2.zsh-theme ]; then \
		current_target=$$(readlink $(HOME)/.oh-my-zsh/themes/gentoo2.zsh-theme); \
		if [ "$$current_target" = "$(CURDIR)/gentoo2.zsh-theme" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ Theme symlink already points to $(CURDIR)/gentoo2.zsh-theme"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Theme symlink exists but points to: $$current_target"; \
		fi \
	elif [ -e $(HOME)/.oh-my-zsh/themes/gentoo2.zsh-theme ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ Theme file exists but is not a symlink"; \
	else \
		ln -s $(CURDIR)/gentoo2.zsh-theme $(HOME)/.oh-my-zsh/themes/gentoo2.zsh-theme; \
		printf "\033[1;32m%s\033[0m\n" "✓ Theme symlink created: $(HOME)/.oh-my-zsh/themes/gentoo2.zsh-theme -> $(CURDIR)/gentoo2.zsh-theme"; \
	fi
	@$(call print_colored,"Setting up .zshrc symlink...")
	@if [ -L $(HOME)/.zshrc ]; then \
		current_target=$$(readlink $(HOME)/.zshrc); \
		if [ "$$current_target" = "$(CURDIR)/.zshrc" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ .zshrc symlink already points to $(CURDIR)/.zshrc"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ .zshrc symlink exists but points to: $$current_target"; \
			backup_file=$(HOME)/.zshrc-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Creating backup at $$backup_file..."; \
			mv $(HOME)/.zshrc $$backup_file; \
			ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc; \
			printf "\033[1;32m%s\033[0m\n" "✓ .zshrc symlink created: $(HOME)/.zshrc -> $(CURDIR)/.zshrc"; \
		fi \
	elif [ -e $(HOME)/.zshrc ]; then \
		backup_file=$(HOME)/.zshrc-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Backing up existing .zshrc to $$backup_file..."; \
		mv $(HOME)/.zshrc $$backup_file; \
		ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc; \
		printf "\033[1;32m%s\033[0m\n" "✓ Backup created at $$backup_file"; \
		printf "\033[1;32m%s\033[0m\n" "✓ .zshrc symlink created: $(HOME)/.zshrc -> $(CURDIR)/.zshrc"; \
	else \
		ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc; \
		printf "\033[1;32m%s\033[0m\n" "✓ .zshrc symlink created: $(HOME)/.zshrc -> $(CURDIR)/.zshrc"; \
	fi

clean-oh-my-zsh:
	@$(call print_colored,"Uninstalling Oh My Zsh...")
	@if [ -d $(HOME)/.oh-my-zsh ]; then \
		printf "%s\n" "Removing Oh My Zsh directory..."; \
		rm -rf $(HOME)/.oh-my-zsh; \
		printf "\033[1;32m%s\033[0m\n" "✓ Oh My Zsh uninstalled successfully"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ Oh My Zsh is not installed"; \
	fi

install-tmux: install-brew
ifeq ($(UNAME_S),Darwin)
	@$(call print_colored,"Installing tmux on macOS...")
	@if command -v tmux >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "✓ tmux already installed"; \
		tmux -V; \
	else \
		brew install tmux; \
		printf "\033[1;32m%s\033[0m\n" "✓ tmux installed successfully"; \
		tmux -V; \
	fi
else ifeq ($(UNAME_S),Linux)
	@$(call print_colored,"Installing tmux on Linux...")
	@if command -v tmux >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "✓ tmux already installed"; \
		tmux -V; \
	else \
		if [ -f /etc/os-release ]; then \
			. /etc/os-release; \
			case "$$ID" in \
				ubuntu|debian) \
					printf "%s\n" "Detected Debian/Ubuntu, using apt-get..."; \
					sudo apt-get update && sudo apt-get install -y tmux; \
					;; \
				rhel|centos|fedora) \
					printf "%s\n" "Detected RHEL/CentOS/Fedora..."; \
					if command -v dnf >/dev/null 2>&1; then \
						sudo dnf install -y tmux; \
					else \
						sudo yum install -y tmux; \
					fi; \
					;; \
				arch) \
					printf "%s\n" "Detected Arch Linux, using pacman..."; \
					sudo pacman -S --noconfirm tmux; \
					;; \
				*) \
					printf "\033[1;33m%s\033[0m\n" "⚠ Unknown distribution: $$ID"; \
					printf "%s\n" "  Please install tmux manually"; \
					exit 1; \
					;; \
			esac; \
			printf "\033[1;32m%s\033[0m\n" "✓ tmux installed successfully"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Cannot detect distribution"; \
			printf "%s\n" "  Please install tmux manually"; \
			exit 1; \
		fi \
	fi
else
	@$(call print_colored,"⚠ Unsupported OS: $(UNAME_S)","red")
	@$(call print_colored,"  Please install tmux manually","plain")
endif
	@$(call print_colored,"Verifying tmux installation...")
	@if command -v tmux >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "✓ tmux is installed and available"; \
		$(call print_colored,"Creating tmux config directory..."); \
		mkdir -p $(HOME)/.config/tmux; \
		printf "\033[1;32m%s\033[0m\n" "✓ Config directory created at $(HOME)/.config/tmux"; \
		$(call print_colored,"Creating symlink for .tmux.conf..."); \
		if [ -L $(HOME)/.tmux.conf ]; then \
			current_target=$$(readlink $(HOME)/.tmux.conf); \
			if [ "$$current_target" = "$(CURDIR)/.tmux.conf" ]; then \
				printf "\033[1;32m%s\033[0m\n" "✓ .tmux.conf symlink already points to $(CURDIR)/.tmux.conf"; \
			else \
				printf "\033[1;33m%s\033[0m\n" "⚠ .tmux.conf symlink exists but points to: $$current_target"; \
				backup_file=$(HOME)/.tmux.conf-backup-$$(date +%Y%m%d-%H%M%S); \
				printf "%s\n" "Creating backup at $$backup_file..."; \
				mv $(HOME)/.tmux.conf $$backup_file; \
				ln -s $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf; \
				printf "\033[1;32m%s\033[0m\n" "✓ .tmux.conf symlink created: $(HOME)/.tmux.conf -> $(CURDIR)/.tmux.conf"; \
			fi \
		elif [ -e $(HOME)/.tmux.conf ]; then \
			backup_file=$(HOME)/.tmux.conf-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Backing up existing .tmux.conf to $$backup_file..."; \
			mv $(HOME)/.tmux.conf $$backup_file; \
			ln -s $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf; \
			printf "\033[1;32m%s\033[0m\n" "✓ Backup created at $$backup_file"; \
			printf "\033[1;32m%s\033[0m\n" "✓ .tmux.conf symlink created: $(HOME)/.tmux.conf -> $(CURDIR)/.tmux.conf"; \
		else \
			ln -s $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf; \
			printf "\033[1;32m%s\033[0m\n" "✓ .tmux.conf symlink created: $(HOME)/.tmux.conf -> $(CURDIR)/.tmux.conf"; \
		fi; \
	else \
		printf "\033[1;31m%s\033[0m\n" "✗ tmux is not installed on the system"; \
		printf "\033[1;33m%s\033[0m\n" "⚠ Skipping symlink creation - please install tmux manually first"; \
		exit 1; \
	fi

install-tpm: install-tmux
	@$(call print_colored,"Installing TPM (Tmux Plugin Manager)...")
	@if [ -d $(HOME)/.tmux/plugins/tpm ]; then \
		printf "\033[1;32m%s\033[0m\n" "✓ TPM already installed at $(HOME)/.tmux/plugins/tpm"; \
		cd $(HOME)/.tmux/plugins/tpm && git pull origin master; \
		printf "\033[1;32m%s\033[0m\n" "✓ TPM updated to latest version"; \
	else \
		printf "%s\n" "Cloning TPM repository..."; \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
		printf "\033[1;32m%s\033[0m\n" "✓ TPM installed successfully at $(HOME)/.tmux/plugins/tpm"; \
	fi
	@$(call print_colored,"Installation complete! Reload tmux config and press prefix + I to install plugins","cyan")

install-tmux-powerline: install-tpm
	@$(call print_colored,"Configuring tmux-powerline with gruvbox theme...")
	@if [ ! -d $(HOME)/.tmux/plugins/tmux-powerline ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ tmux-powerline not installed yet"; \
		printf "%s\n" "  Please run: tmux source ~/.tmux.conf"; \
		printf "%s\n" "  Then press prefix + I to install plugins"; \
		exit 1; \
	fi
	@$(call print_colored,"Creating symlink for tmux-powerline config...")
	@if [ -L $(HOME)/.config/tmux-powerline ]; then \
		current_target=$$(readlink $(HOME)/.config/tmux-powerline); \
		if [ "$$current_target" = "$(CURDIR)/.config/tmux-powerline" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ Config symlink already points to $(CURDIR)/.config/tmux-powerline"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Config symlink exists but points to: $$current_target"; \
			backup_dir=$(HOME)/.config/tmux-powerline-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Creating backup at $$backup_dir..."; \
			mv $(HOME)/.config/tmux-powerline $$backup_dir; \
			ln -s $(CURDIR)/.config/tmux-powerline $(HOME)/.config/tmux-powerline; \
			printf "\033[1;32m%s\033[0m\n" "✓ Config symlink created"; \
		fi \
	elif [ -e $(HOME)/.config/tmux-powerline ]; then \
		backup_dir=$(HOME)/.config/tmux-powerline-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Backing up existing config to $$backup_dir..."; \
		mv $(HOME)/.config/tmux-powerline $$backup_dir; \
		ln -s $(CURDIR)/.config/tmux-powerline $(HOME)/.config/tmux-powerline; \
		printf "\033[1;32m%s\033[0m\n" "✓ Backup created and symlink established"; \
	else \
		ln -s $(CURDIR)/.config/tmux-powerline $(HOME)/.config/tmux-powerline; \
		printf "\033[1;32m%s\033[0m\n" "✓ Config symlink created: $(HOME)/.config/tmux-powerline"; \
	fi
	@$(call print_colored,"Configuration complete! Remember to reload tmux config","cyan")

clean-tmux:
	@$(call print_colored,"⚠ WARNING: This will remove tmux and its configuration!","red")
	@$(call print_colored,"This includes:","red")
	@$(call print_colored,"  - tmux installation (via package manager)","plain")
	@$(call print_colored,"  - Configuration symlink (~/.tmux.conf)","plain")
	@echo ""
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		printf "%s\n" "Cleaning tmux..."; \
		$(call print_colored,"Removing .tmux.conf symlink..."); \
		if [ -L $(HOME)/.tmux.conf ]; then \
			current_target=$$(readlink $(HOME)/.tmux.conf); \
			if [ "$$current_target" = "$(CURDIR)/.tmux.conf" ]; then \
				rm $(HOME)/.tmux.conf; \
				printf "\033[1;32m%s\033[0m\n" "✓ Symlink removed: $(HOME)/.tmux.conf"; \
			else \
				printf "\033[1;33m%s\033[0m\n" "⚠ Symlink points to different location: $$current_target"; \
				printf "%s\n" "  Not removing to prevent data loss"; \
			fi \
		elif [ -e $(HOME)/.tmux.conf ]; then \
			printf "\033[1;33m%s\033[0m\n" "⚠ $(HOME)/.tmux.conf exists but is not a symlink"; \
			printf "%s\n" "  Not removing to prevent data loss"; \
		else \
			printf "\033[1;32m%s\033[0m\n" "✓ No symlink found at $(HOME)/.tmux.conf"; \
		fi; \
		$(call print_colored,"Uninstalling tmux..."); \
		if command -v tmux >/dev/null 2>&1; then \
			if [ "$(UNAME_S)" = "Darwin" ]; then \
				if command -v brew >/dev/null 2>&1; then \
					brew uninstall tmux || printf "\033[1;33m%s\033[0m\n" "⚠ Failed to uninstall tmux via brew"; \
					printf "\033[1;32m%s\033[0m\n" "✓ tmux uninstalled from macOS"; \
				else \
					printf "\033[1;33m%s\033[0m\n" "⚠ Homebrew not found, cannot uninstall tmux"; \
				fi \
			elif [ "$(UNAME_S)" = "Linux" ]; then \
				if [ -f /etc/os-release ]; then \
					. /etc/os-release; \
					case "$$ID" in \
						ubuntu|debian) \
							sudo apt-get remove -y tmux && sudo apt-get autoremove -y; \
							printf "\033[1;32m%s\033[0m\n" "✓ tmux uninstalled from Debian/Ubuntu"; \
							;; \
						rhel|centos|fedora) \
							if command -v dnf >/dev/null 2>&1; then \
								sudo dnf remove -y tmux; \
							else \
								sudo yum remove -y tmux; \
							fi; \
							printf "\033[1;32m%s\033[0m\n" "✓ tmux uninstalled from RHEL/CentOS/Fedora"; \
							;; \
						arch) \
							sudo pacman -R --noconfirm tmux; \
							printf "\033[1;32m%s\033[0m\n" "✓ tmux uninstalled from Arch Linux"; \
							;; \
						*) \
							printf "\033[1;33m%s\033[0m\n" "⚠ Unknown distribution: $$ID"; \
							printf "%s\n" "  Please uninstall tmux manually"; \
							;; \
					esac \
				else \
					printf "\033[1;33m%s\033[0m\n" "⚠ Cannot detect distribution"; \
					printf "%s\n" "  Please uninstall tmux manually"; \
				fi \
			else \
				printf "\033[1;33m%s\033[0m\n" "⚠ Unsupported OS: $(UNAME_S)"; \
				printf "%s\n" "  Please uninstall tmux manually"; \
			fi \
		else \
			printf "\033[1;32m%s\033[0m\n" "✓ tmux is not installed"; \
		fi; \
		printf "\033[1;32m%s\033[0m\n" "✓ tmux cleanup complete"; \
	else \
		printf "%s\n" "Cleanup cancelled"; \
	fi

clean-tmux-powerline:
	@$(call print_colored,"Removing tmux-powerline config symlink...")
	@if [ -L $(HOME)/.config/tmux-powerline ]; then \
		current_target=$$(readlink $(HOME)/.config/tmux-powerline); \
		if [ "$$current_target" = "$(CURDIR)/.config/tmux-powerline" ]; then \
			rm $(HOME)/.config/tmux-powerline; \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink removed: $(HOME)/.config/tmux-powerline"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink points to different location: $$current_target"; \
			printf "%s\n" "  Not removing to prevent data loss"; \
		fi \
	elif [ -e $(HOME)/.config/tmux-powerline ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ $(HOME)/.config/tmux-powerline exists but is not a symlink"; \
		printf "%s\n" "  Not removing to prevent data loss"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ No symlink found at $(HOME)/.config/tmux-powerline"; \
	fi

install-fonts: install-brew
ifeq ($(UNAME_S),Darwin)
	@$(call print_colored,"Installing Nerd Fonts on macOS...")
	@for font in $(NERD_FONTS); do \
		printf "%s\n" "Installing $$font..."; \
		brew install --cask $$font || printf "\033[1;33m%s\033[0m\n" "⚠ Failed to install $$font"; \
	done
	@$(call print_colored,"✓ Nerd Fonts installation complete")
else ifeq ($(UNAME_S),Linux)
	@$(call print_colored,"Installing Nerd Fonts on Linux...")
	@mkdir -p $(HOME)/.local/share/fonts
	@for font in $(NERD_FONTS); do \
		font_name=$$(echo $$font | sed 's/font-//;s/-nerd-font//;s/-/ /g'); \
		printf "%s\n" "Downloading $$font_name..."; \
		curl -fLo "$(HOME)/.local/share/fonts/$$font.zip" \
			"https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$$font_name.zip" || \
			printf "\033[1;33m%s\033[0m\n" "⚠ Failed to download $$font"; \
		unzip -o "$(HOME)/.local/share/fonts/$$font.zip" -d "$(HOME)/.local/share/fonts/" 2>/dev/null || true; \
		rm -f "$(HOME)/.local/share/fonts/$$font.zip"; \
	done
	@fc-cache -fv
	@$(call print_colored,"✓ Nerd Fonts installation complete")
else
	@$(call print_colored,"⚠ Unsupported OS: $(UNAME_S)","red")
endif

test-nerd-fonts: test-smoke

test-smoke:
	@$(call print_colored,"Running Nerd Fonts Smoke Test...","cyan")
	@bash .tests/smoke-test.sh

test-unicode:
	@$(call print_colored,"Running Unicode Range Test...","cyan")
	@bash .tests/unicode-range-test.sh

test-icons:
	@$(call print_colored,"Running Comprehensive Icon Sets Test...","cyan")
	@bash .tests/icon-sets-test.sh

test-all:
	@$(call print_colored,"Running All Nerd Fonts Tests...","cyan")
	@echo ""
	@$(call print_colored,"[1/3] Smoke Test","yellow")
	@bash .tests/smoke-test.sh
	@echo ""
	@$(call print_colored,"[2/3] Unicode Range Test","yellow")
	@bash .tests/unicode-range-test.sh
	@echo ""
	@$(call print_colored,"[3/3] Comprehensive Icon Sets Test","yellow")
	@bash .tests/icon-sets-test.sh
	@echo ""
	@$(call print_colored,"All tests completed!","green")
